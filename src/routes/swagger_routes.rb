class SwaggerRoutes < Sinatra::Base
  configure do
    set :views, File.expand_path('../../views', __dir__)
  end

  # Configuração do Swagger UI
  get '/api-docs' do
    erb :swagger
  end

  get '/swagger.json' do
    content_type :json
    File.read(File.expand_path('../../../swagger.yml', __FILE__))
  end
end 