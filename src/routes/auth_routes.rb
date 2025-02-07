class AuthRoutes < Sinatra::Base
  helpers Sinatra::JSON

  before do
    content_type :json
    request.body.rewind
    @request_payload = JSON.parse(request.body.read) rescue {}
  end

  # Rota para primeiro usuário admin
  post '/first-user' do
    controller = Controllers::AuthController.new(request)
    controller.first_user
  end

  # Rotas de login
  post '/customer/login' do
    controller = Controllers::AuthController.new(request)
    controller.customer_login
  end

  post '/admin/login' do
    controller = Controllers::AuthController.new(request)
    controller.admin_login
  end
end 