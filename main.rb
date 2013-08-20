require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require_relative "todo"
require_relative "category"

ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql', 
	:host => 'localhost', 
	:username => 'franklinwahl',
	:password => '',
	:database => 'todo',
	:encoding => 'utf8'
)


get "/" do
	@todos = Todo.includes(:category)
	erb :index
end

get "/new_todo" do
	@categories = Category.all
	erb :new_todo
end

get "/new_category" do
	erb :new_category
end

get "/list/:cat" do
	@todos = Category.find_by_id(params[:cat]).todo
	erb :index
end

post "/new_category" do
	cat = Category.new(:name => params[:category_name])
	if cat.save
		redirect "/"
	else
		erb :new_category
	end
end

post "/new_todo" do
	todo = Todo.new(:name => params[:todo_name], :author => params[:todo_author], :done => params[:todo_done], :category_id => params[:category])
	#todo = Todo.new(:name => params[:todo_name], :author => params[:todo_author], :done => params[:todo_done])
	if todo.save
		redirect "/"
	else
		get "/new_todo"
	end
end

post "/Delete/:id" do
	todo = Todo.find_by_id(params[:id])
	todo.destroy
	redirect "/"
end
	
post "/Toggle/:id" do
	todo = Todo.find_by_id(params[:id])
	todo.update_attributes(:done => !todo.done)
	redirect "/"
end
