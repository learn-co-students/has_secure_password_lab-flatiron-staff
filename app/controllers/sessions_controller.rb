class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_name(params[:user][:name])
    
    redirect_to 'sessions#new' and return if user.nil?

    return head(:forbidden) unless user.authenticate(params[:user][:password])

    login!(user)
  end

  def destroy
  end
end