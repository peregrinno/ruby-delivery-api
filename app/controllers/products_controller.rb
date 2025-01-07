get '/products' do
  Product.all.to_json
end

post '/products' do
  payload = JSON.parse(request.body.read)
  product = Product.new(payload)

  if product.save
    status 201
    product.to_json
  else
    status 422
    product.errors.to_json
  end
end
