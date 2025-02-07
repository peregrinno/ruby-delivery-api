class AdminRoutes < Sinatra::Base
  helpers Sinatra::JSON

  before do
    content_type :json
    request.body.rewind
    @request_payload = JSON.parse(request.body.read) rescue {}
  end

  # Rotas de usuários
  get '/admin/users' do
    controller = Controllers::UserController.new(request)
    result = controller.index
    
    if result.is_a?(Hash) && result[:status]
      status result[:status]
      headers result[:headers] if result[:headers]
      result[:response]
    else
      result
    end
  end

  post '/admin/users' do
    controller = Controllers::UserController.new(request)
    result = controller.create
    
    if result.is_a?(Hash) && result[:status]
      status result[:status]
      headers result[:headers] if result[:headers]
      result[:response]
    else
      result
    end
  end

  put '/admin/users/:id' do
    controller = Controllers::UserController.new(request)
    result = controller.update
    
    if result.is_a?(Hash) && result[:status]
      status result[:status]
      headers result[:headers] if result[:headers]
      result[:response]
    else
      result
    end
  end

  delete '/admin/users/:id' do
    controller = Controllers::UserController.new(request)
    result = controller.delete
    
    if result.is_a?(Hash) && result[:status]
      status result[:status]
      headers result[:headers] if result[:headers]
      result[:response]
    else
      result
    end
  end

  # Rotas de produtos
  get '/admin/products' do
    controller = Controllers::ProductController.new(request)
    result = controller.index
    
    if result.is_a?(Hash) && result[:status]
      status result[:status]
      headers result[:headers] if result[:headers]
      result[:response]
    else
      result
    end
  end

  post '/admin/products' do
    controller = Controllers::ProductController.new(request)
    result = controller.create
    
    if result.is_a?(Hash) && result[:status]
      status result[:status]
      headers result[:headers] if result[:headers]
      result[:response]
    else
      result
    end
  end

  put '/admin/products/:id' do
    controller = Controllers::ProductController.new(request)
    result = controller.update(params['id'])
    
    if result.is_a?(Hash) && result[:status]
      status result[:status]
      headers result[:headers] if result[:headers]
      result[:response]
    else
      result
    end
  end

  delete '/admin/products/:id' do
    controller = Controllers::ProductController.new(request)
    controller.delete
  end

  # Rotas de pedidos
  get '/admin/orders' do
    controller = Controllers::OrderController.new(request)
    result = controller.index
    
    if result.is_a?(Hash) && result[:status]
      status result[:status]
      headers result[:headers] if result[:headers]
      result[:response]
    else
      result
    end
  end

  put '/admin/orders/:id/status' do
    controller = Controllers::OrderController.new(request)
    result = controller.update_status(params['id'])
    
    if result.is_a?(Hash) && result[:status]
      status result[:status]
      headers result[:headers] if result[:headers]
      result[:response]
    else
      result
    end
  end
end 