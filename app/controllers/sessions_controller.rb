class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:alert] = 'Invalid username.'
      render :new 
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_url
  end
end
