class ApplicationController < ActionController::Base
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      session[:request] = request.url
      flash[:alert] = 'You must be logged in to access this section.'
      redirect_to new_session_path
    end
  end
end
