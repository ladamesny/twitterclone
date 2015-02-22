class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_username(params[:username])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id

			flash[:notice] = "Welcome #{user.username}! You're logged in."
			redirect_to user_path(user.username)
		else
			flash.now[:error] = "Sorry, something went wrong. Please try again."
			render :new
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You've logged out."
		redirect_to login_path
	end
end