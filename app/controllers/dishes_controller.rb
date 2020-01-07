class DishesController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :authenticate_user!, except: [:index,:show,:search,:autocomplete]
	before_action :set_dish,only:[:show,:edit,:update]
	def index
		@search = Dish.includes(:images).ransack(params[:q])
		@search.sorts = ['created_at DESC'] if @search.sorts.empty?
		@dishes = @search.result.paginate(page:params[:page],per_page:9)
	end
	def healthy
	end
	def autocomplete
		if params[:category] == ""
			@dishes =Dish.distinct.order(:name).where("name Ilike ?","#{params[:term]}%").pluck(:name)
		else
			@dishes = Dish.distinct.order(:name).where("category_id = ? AND name Ilike ?",params[:category].to_i,"#{params[:term]}%").pluck(:name)
		end
		render json: @dishes 
	end
	def search
		if params[:sort] == 'recent' 
			@dishes = Dish.order('created_at DESC')
		elsif params[:sort] == 'rating'
			@dishes = Dish.all.sort_by{|d|d.reviews.average(:rating).to_f}.reverse 
		end
		respond_to do |format|
    	format.html
    	format.js
    end
	end

	def new
		@search = Dish.includes(:images).ransack(params[:q])
		@dishes = @search.result
		@dish = Dish.new
		@dish.images.build
		add_breadcrumb I18n.t("breadcrumbs.post"),  :new_dish_path
	end
	def create
		@dish = current_user.dishes.new(dish_params)
		if @dish.save!
			flash[:success] = "Dish Posted Successfully"
			redirect_to root_path
		else
			flash[:error] = "Dish not Posted"
			redirect_to new_dish_path
		end
	end
	def show
		@search = Dish.includes(:images).ransack(params[:q])
		@dishes = @search.result
		@reviews = @dish.reviews.includes(:user)
		add_breadcrumb I18n.t("breadcrumbs.dish") 
	end
	def edit
		# @dish.images.build
	end
	def update
		@dish.update(dish_params)
		redirect_to user_session_path
	end
	private
		def dish_params
			params.require(:dish).permit(:name,:price,:description,:category_id,images_attributes:[:id,:image])
		end
		def set_dish
			@dish = Dish.find_by(id:params[:id])
		end
end