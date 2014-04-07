class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :delete]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = "You have signed up"
      redirect_to items_path
    else
      render 'new'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end