class AddColumnToTodosForCategory < ActiveRecord::Migration
  def up
		add_column :todos, :category_id, :integer
  end

  def down
		remove_column :todos, :category_id
  end
end
