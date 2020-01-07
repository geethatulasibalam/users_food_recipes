class ReviewsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_dish 
	rescue_from ActiveRecord::RecordInvalid, :with => :review_error
	def index
	end
	def new
		@review = Review.new
		add_breadcrumb I18n.t("breadcrumbs.dish"), dish_path(@dish)
		add_breadcrumb I18n.t("breadcrumbs.newreview"),new_dish_review_path, :only => %w(newreview)
	end
	def create
		@review = @dish.reviews.create(review_params)
		respond_to do |format|
			if @review.save!
			format.html{redirect_to dish_path(@dish),flash:{success:'Review Created Successfully'}}
			end
		end
	end
	def show
	end
	private
		def review_params
			params[:review][:user_id] = current_user.id
			params.require(:review).permit(:rating,:review,:dish_id,:user_id)
		end
		def set_dish
			@dish=Dish.find_by(id:params[:dish_id])
		end
		def review_error
			flash[:error] = 'You can not give more than one review'
			redirect_to dish_path(@dish)
		end
		# protected
		# def authenticate_user!
		# 	if user_signed_in?
		# 		super
		# 	else
		# 		flash[:error] = 'You need to sign in before giving review'
		# 	end
		# end

end