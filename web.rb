require 'sinatra'
require 'sinatra/formkeeper'
require "sinatra/reloader" if development?

get '/' do
  haml :index
end