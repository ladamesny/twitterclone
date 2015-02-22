class StatusesController < ApplicationController
	def new
		@status = Status.new
	end

	def create
		@status = Status.new(status_params)
		@status.creator = current_user
		if @status.save
			flash[:notice] = "Status was created!"
			redirect_to user_path(@status.creator.username)
		else
			flash[:notice] = "Status could not be created"
			render :new
		end
	end

	private

	def status_params
		params.require(:status).permit(:body)
	end
end