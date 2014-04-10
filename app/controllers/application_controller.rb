class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private
  
  helper_method :current_user
  
  def current_user
    @user ||= User.find(session['user_id']) if session['user_id']
  end
  
  def require_signin
    unless current_user
      flash[:notice] = "You must sign in"
      redirect_to items_path
    end
  end
  
  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "You do not have permission to do this"
      redirect_to items_path
    end
  end
end
