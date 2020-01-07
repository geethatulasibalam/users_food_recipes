class Review < ApplicationRecord
	belongs_to :dish
	belongs_to :user
	validates :rating,:review,presence: true
	validates_uniqueness_of :user_id, scope: :dish_id 
end
