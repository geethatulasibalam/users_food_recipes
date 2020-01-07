class Dish < ApplicationRecord
	belongs_to :user
	has_many :images,dependent: :destroy
	accepts_nested_attributes_for :images
	validates :name,presence: true, length:{maximum: 30}
	validates :price,:description,presence: true
	ratyrate_rateable "taste"
	has_many :reviews,dependent: :destroy
	has_many :users, through: :reviews
	belongs_to :category
	def average_stars
		self.reviews.average(:rating)
	end
end
