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
@cookbook = Cookbook.new('./recipes.csv')

get '/' do
  @recipes = @cookbook.all
  erb :index
end
