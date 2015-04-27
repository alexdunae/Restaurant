class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  helper_method :current_client, :current_table, :sign_in_waiter, :current_waiter, :is_admin

  def current_client
    # you may want to use conditional assignment here so you don't keep hitting the database:
    @current_client ||= if session.key?(:client_id)
      Client.find(session[:client_id])
    else
      nil
    end
  end

  def current_table
    if session.key?(:table_id)
      Table.find(session[:table_id])
    else
      nil
    end
  end

  def current_waiter
    if session.key?(:waiter_id)
      Waiter.find(session[:waiter_id])
    else
      nil
    end
  end

  def sign_in_waiter(user)
    session[:waiter_id] = user.id
  end

  def is_admin(user)
    if user.present?
      user.admin
    else
      false
    end
  end

end
