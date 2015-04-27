class TablesController < ApplicationController
	around_filter :catch_not_found

	def welcome
	end

	def create
		@table = Table.new(table_params)
	    if @table.save
	      flash[:success] = 'Table successfully created!'
	      redirect_to :back
	    end
	end

	def show
		@table = Table.find(params[:id])

		if current_waiter.present?
			session[:table_id] = @table.id
		end

		if current_table.present? && current_table != @table
			redirect_to table_path(current_table)
		end

		@client = Client.new
	end

	def edit
		@table_edit = Table.find(params[:id])
	end

	def update
		@table = Table.find(params[:id])
	    if @table.update_attributes(table_params)
	    	@table.save
	    	flash[:success] = "Table successfully edited"
	    	redirect_to waiters_manage_tables_path
	    else
	    	render :edit
	    end
	end

	def redirect_to_table
		@table = Table.find_by(:code => params[:code])
		if @table.present?
			session[:table_id] = @table.id
			redirect_to table_path(session[:table_id])
		else
			flash[:error] = "Incorrect code!"
			redirect_to root_path
		end

	end

	def toggle_request
		@table = Table.find(params[:table_id])
		@table.requested = !@table.requested
		@table.save
		redirect_to :back
	end

	def finish_table
		@table = Table.find(params[:table_id])
		done = true

		@order = Order.new
		@order.total = @table.owe

		@table.clients.each do |c|
			if !c.done
				done = false
			end
			c.dishes.each do |d|

				@order.dishes << d
			end
		end
		if !done
			flash[:error] = "All clients must be done before finish table"
			redirect_to :back
		else
			@order.save
		  @table.clients = []
		  @table.requested = false
		  @table.save
		  redirect_to waiters_tables_path
		end

	end

	def destroy
		@table = Table.find(params[:id])
		flash[:success] = 'Table successfully removed!'
		@table.destroy
		redirect_to :back
	end

	# neat!
	def catch_not_found
	  yield
	  rescue ActiveRecord::RecordNotFound
	  redirect_to root_url, :flash => { :error => "Record not found." }
  end

  def table_params
    params.require(:table).permit(:code, :number, :waiter_id)
  end
end
