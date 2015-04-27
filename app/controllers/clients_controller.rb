class ClientsController < ApplicationController
  around_filter :catch_not_found
  before_action :lookup_table

	def show
    @client = Client.find(params[:id])

    if current_waiter.present?
      session[:client_id] = @client.id
      session[:table_id] = @client.table.id
    end

    if @client.id != session[:client_id]  && !current_waiter.present?
      redirect_to root_path
    end
    session[:client_id] = @client.id
	end

  def new
    @client = @table.clients.new
  end

  def add_dish
    flash[:success] = "Dish - wait for it -  Ordered!"
    @client = Client.find(session[:client_id])
    @dish = Dish.find(params[:dish_id])
    @client.dishes << @dish
    @client.save
    redirect_to table_client_path(@client.table,@client)
  end

  def create
    @client = @table.clients.new(client_params)
    if @client.save
      session[:client_id] = @client.id
      flash[:message] = "Welcome"
      redirect_to table_client_path(@client.table,@client)
    else
      render 'new'
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to waiters_tables_path
  end

  def toggle_check_out
    @client = Client.find(params[:id])
    @client.payment_method = params[:payment_method]
    @client.checking_out = !@client.checking_out
    @client.save
    redirect_to :back
  end

  def toggle_done
    @client = Client.find(params[:id])
    @client.checking_out = false
    @client.done = !@client.done
    @client.save
    redirect_to :back
  end

  # you don't need this one since it's already in your ApplicationController
  def catch_not_found
    yield
    rescue ActiveRecord::RecordNotFound
    redirect_to root_url, :flash => { :error => "Record not found." }
  end

  private

  def client_params
    params.require(:client).permit(:name,:done,:howManyTime,:table_id)
  end

  def lookup_table
    @table = Table.find(params[:table_id])
  end
end
