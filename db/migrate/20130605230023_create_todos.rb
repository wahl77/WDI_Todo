class CreateTodos < ActiveRecord::Migration
  def up
		create_table :todos do |todo|
			todo.boolean :done
			todo.string :author
			todo.string :name
		end

  end

  def down
		drop_table :todos
  end
end
