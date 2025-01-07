require 'sinatra'
require 'sinatra/reloader' if development?
require 'mongoid'
require 'json'
require "dotenv-vault/load"

Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

Dir['./app/**/*.rb'].each { |file| require file }

configure :development do
  register Sinatra::Reloader
end

set :public_folder, 'public'

before do
  content_type :json
end

get '/' do
  redirect '/swagger-ui/index.html'
end


helpers AuthHelper