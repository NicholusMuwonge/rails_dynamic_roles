class Users::UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user, only: %i[show]
	
	def index
		@users = User.where(publisher: current_user.publisher).all
		# authorize current_user
	end

	def show
	end

	private

	def set_user
		@user = User.find(params["id"])
	end
end