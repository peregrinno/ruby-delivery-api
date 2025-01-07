post '/customers' do
  payload = JSON.parse(request.body.read)
  customer = Customer.new(payload)

  if customer.save
    status 201
    customer.to_json(except: [:password])
  else
    status 422
    customer.errors.to_json
  end
end
