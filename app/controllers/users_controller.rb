class UsersController < ApplicationController
  def new
    @user = User.new    
  end
  
  def create
    @user = User.new(user_params)    
    
    if @user.save
      flash[:success] = "You've signed up succesfully"
      redirect_to @user
    else
      flash[:alert] = 'Unsuccesful signup'
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :username)
  end
end
