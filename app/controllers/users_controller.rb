class UsersController < ApplicationController
	def home
		redirect_to new_user_session_path
		# @dishes = Dish.all
	end
end