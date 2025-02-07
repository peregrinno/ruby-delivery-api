class CustomerRoutes < Sinatra::Base
  helpers Sinatra::JSON

  before do
    content_type :json
    @request_payload = JSON.parse(request.body.read) rescue {}
  end

  # Registro de cliente
  post '/customer/register' do
    controller = Controllers::CustomerController.new(request)
    controller.register
  end

  # Criação de pedido
  post '/customer/orders' do
    controller = Controllers::CustomerController.new(request)
    controller.create_order
  end

  # Listagem dos pedidos do cliente
  get '/customer/orders' do
    controller = Controllers::OrderController.new(request)
    controller.customer_orders
  end
end 