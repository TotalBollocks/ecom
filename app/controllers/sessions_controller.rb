class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.where(email: params[:email]).first
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have logged in"
      redirect_to items_path
    else
      flash[:alert] = "Email or password is incorrect"
      render 'new'
    end
  end
  
  def destroy
    session['user_id'] = nil
    flash[:notice] = "You have logged out" 
    redirect_to root_path
  end
end
