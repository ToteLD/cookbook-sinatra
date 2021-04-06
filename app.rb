require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require 'csv'
require_relative 'cookbook'
require_relative 'recipe'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  cookbook = Cookbook.new('./recipes.csv')
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  @cookbook = Cookbook.new('./recipes.csv')
  recipe = Recipe.new(params[:name], params[:description], params[:rating], params[:prep_time])
  @cookbook.add_recipe(recipe)
  redirect '/'
end

get '/recipes/:index' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  cookbook.remove_recipe(params[:index].to_i)
  redirect to '/'
end
