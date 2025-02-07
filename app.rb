require 'sinatra'
require 'sinatra/json'
require 'sinatra/cross_origin'
require 'jwt'
require 'json'
require 'bcrypt'
require 'dotenv'
require 'mongoid'
require 'active_support/time'
require 'yaml'

# Carrega as variáveis de ambiente
Dotenv.load

# Configuração básica do Sinatra
configure do
  enable :cross_origin
  set :protection, except: [:json_csrf]
  set :show_exceptions, false
  set :public_folder, File.dirname(__FILE__)
end

# Configuração do CORS
before do
  response.headers['Access-Control-Allow-Origin'] = ENV['CORS_URL']
  response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'Authorization, Content-Type'
  response.headers['Access-Control-Allow-Credentials'] = 'true'
end

options "*" do
  response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept, Authorization"
  200
end

# Tratamento global de erros
error Mongoid::Errors::DocumentNotFound do
  status 404
  json error: 'Recurso não encontrado'
end

error Mongoid::Errors::Validations do
  status 400
  json error: env['sinatra.error'].message
end

error JWT::DecodeError do
  status 401
  json error: 'Token inválido'
end

error do
  status 500
  json error: 'Erro interno do servidor'
end

# Carrega os arquivos na ordem correta
Dir["./src/lib/*.rb"].sort.each { |file| require file }
Dir["./src/config/*.rb"].sort.each { |file| require file }
Dir["./src/middlewares/*.rb"].sort.each { |file| require file }
Dir["./src/models/*.rb"].sort.each { |file| require file }

# Carrega os controllers em ordem
require './src/controllers/application_controller'
require './src/controllers/base_controller'
Dir["./src/controllers/*_controller.rb"].sort.each do |file|
  next if file.include?('application_controller.rb') || file.include?('base_controller.rb')
  require file
end

# Carrega as rotas
require './src/routes/swagger_routes'
require './src/routes/auth_routes'
require './src/routes/customer_routes'
require './src/routes/admin_routes'
require './src/routes/product_routes'
require './src/routes/router'

# Classe principal da aplicação
class DeliveryApp < Sinatra::Base
  configure do
    enable :cross_origin
    set :protection, except: [:json_csrf]
  end

  # Middleware para preservar o body da requisição
  before do
    if request.content_type == 'application/json'
      request.body.rewind
      @request_payload = JSON.parse(request.body.read) rescue {}
    end
  end

  # Monta todas as rotas
  use Router
end

# Inicia a aplicação se executado diretamente
if __FILE__ == $0
  DeliveryApp.run!
end