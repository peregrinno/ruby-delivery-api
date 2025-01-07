require 'jwt'

post '/login' do
  payload = JSON.parse(request.body.read)
  customer = Customer.where(email: payload['email']).first

  if customer&.authenticate(payload['password'])
    token = JWT.encode({ customer_id: customer.id, exp: Time.now.to_i + 3600 }, 'secret_key', 'HS256')
    { token: token }.to_json
  else
    status 401
    { error: 'Credenciais inválidas' }.to_json
  end
end
