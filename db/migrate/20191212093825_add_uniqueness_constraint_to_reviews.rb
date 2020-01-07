class AddUniquenessConstraintToReviews < ActiveRecord::Migration[5.2]
  def change
  	add_index  :reviews, [:user_id, :dish_id],
    name:"udx_reviews_on_user_and_product", unique: true
  end
end
