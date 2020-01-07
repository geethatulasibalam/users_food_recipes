class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
    	t.string :image
    	t.belongs_to :dish, index: true
      t.timestamps
    end
  end
end
