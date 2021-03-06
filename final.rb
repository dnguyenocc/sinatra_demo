=begin 
Created on Feb 2nd, 2016
A toy Sinatra app to demostrate the basic concept of MVC, RESTful Routes and CRUD.
Run ``bundle install`` to make sure you have necessary gems installed.
TO run the script, type ``ruby final.rb`` in command line.
@author: hezheng.yin
=end

# load libraries we need 
require 'sinatra'
require 'json'

require './todo'

# display all todos
get '/todos' do 
	content_type :json
	Todo.all.to_json
end

# show a specific todo 
get '/todos/:id' do 
	content_type :json
	todo = Todo.find_by_id(params[:id])
	if todo 
		return {description: todo.description}.to_json
	else
		return {msg: "error: specified todo not found"}.to_json
	end
end

# create a new todo 
# goal: if we receive non-empty description, render json with msg set to "create success"
# 			otherwise render json with msg set to "error: description can't be blank"
post '/todos' do
	content_type :json
	todo = Todo.new(description: params[:description])
	if todo.save
		return {msg: "create success"}.to_json
	else
		return {msg: todo.errors}.to_json
	end
end

# update a todo
# return: if todo with specified id exist and description non-empty, render json with msg set to "update success"
# 				otherwise render json with msg set to "upate failure" 
put '/todos/:id' do
	content_type :json
	todo = Todo.find(params[:id])
	if todo.update_attribute(:description, params[:description])
		return {msg: "update success"}.to_json
	else
		return {msg: todo.errors}.to_json
	end
end

# delete a todo
# return: if todo with specified id exist, render json with msg set to "delete success"
# 				otherwise render json with msg set to "delete failure"
delete '/todos/:id' do 
	content_type :json
	todo = Todo.find(params[:id])
	if todo
		todo.destroy
		return {msg: "delete success"}.to_json
	else
		return {msg: "delete failure"}.to_json
	end
end