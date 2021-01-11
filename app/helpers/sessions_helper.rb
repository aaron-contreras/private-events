module SessionsHelper
  def signed_in_user
    User.find(session[:user_id]) if session[:user_id]
  end
end
