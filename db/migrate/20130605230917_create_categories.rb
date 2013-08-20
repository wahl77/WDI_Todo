class CreateCategories < ActiveRecord::Migration
  def up
		create_table :categories do |category|
			category.string :name
		end
  end

  def down
		drop_table :categories
  end
end
