class ProductRoutes < Sinatra::Base
  helpers Sinatra::JSON

  # Rota pública para listar produtos
  get '/products' do
    controller = Controllers::ProductController.new(request)
    controller.index
  end
end 