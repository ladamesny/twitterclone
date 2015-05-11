class UsersController < ApplicationController
	include UserHelper
	before_action :authenticate_user!, only: [:follow, :timeline, :mentions]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Thank you for registering!"
			redirect_to user_path(@user)
		else
			flash[:notice] = "Sorry, something went wrong. Please try again..."
			render :new
		end
	end

	def show
		@user = User.find_by_username params[:username]
	end

	def follow
		user = User.find(params[:id])
		if user
			update_follow(user)
		else
			wrong_path
		end
		redirect_to user_path(user)
	end

	def timeline
		@statuses = []
		current_user.following_users.each do |user|
			user.statuses.each do |status|
				@statuses << status
			end
		end
	end

	def mentions
		@mentions = current_user.mentions
		current_user.mark_unread_mentions!
	end

	private

	def user_params
		params.require(:user).permit!
	end

	def update_follow(user)
		if current_user.following_users.include?(user)
			flash[:notice] = "You stopped following @#{user.username}"
			rel = Relationship.where(follower: current_user, leader: user).first
			rel.destroy
		else
			flash[:notice] = "You are now following @#{user.username}"
			current_user.following_users << user
		end
	end

end
