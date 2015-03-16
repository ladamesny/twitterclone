class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # these become helper methods so that they can be used on view templates. We don't need require_user as a helper method since it will only be used in controllers.
  helper_method :current_user, :logged_in?

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

  def require_user
  	if !logged_in?
  		flash[:error] = "You must be logged in to do that."
  		redirect_to root_path
  	end
  end

  def wrong_path
    flash[:error] = "There was a problem with your request"
    redirect_to root_path
  end
end
