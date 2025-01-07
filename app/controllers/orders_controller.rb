# Criar ordem
post '/orders' do
  authenticate!

  payload = JSON.parse(request.body.read)
  customer = @current_user

  unless customer.id.to_s == payload['customer_id']
    halt 403, { error: 'Você não tem permissão para criar ordens para outro cliente' }.to_json
  end

  order_details_payload = payload['order_details']
  total = 0
  order_details_payload.each do |detail|
    product = Product.find(detail['product_id'])
    total += product.price * detail['quantity']
  end

  order = Order.new(
    customer: customer,
    total: total,
    order_date: Time.now,
    status: Order::STATUS_UIDS[:waiting_approval],
    last_status_update: Time.now
  )

  if order.save
    order_details = []
    order_details_payload.each do |detail|
      product = Product.find(detail['product_id'])
      order_detail = OrderDetail.new(
        order: order,
        product: product,
        quantity: detail['quantity'],
        subtotal: product.price * detail['quantity']
      )
      halt 422, { error: order_detail.errors.full_messages }.to_json unless order_detail.save

      order_details << order_detail
    end

    status 201
    { order: order, order_details: order_details }.to_json
  else
    halt 422, { error: order.errors.full_messages }.to_json
  end
end

# Atualizar status das ordens
put '/orders/:id/status' do
  authenticate!

  order = Order.find(params[:id])
  payload = JSON.parse(request.body.read)
  new_status = payload['status']

  unless order.can_change_status_to?(new_status)
    halt 400, { error: 'Transição de status inválida ou ordem já entregue' }.to_json
  end

  order.status = new_status
  order.last_status_update = Time.now

  if order.save
    status 200
    { order: order }.to_json
  else
    halt 422, { error: order.errors.full_messages }.to_json
  end
end

# Listar Ordens
get '/orders' do
  authenticate!

  start_date = params['start_date'] ? Date.parse(params['start_date']).beginning_of_day : nil
  end_date = params['end_date'] ? Date.parse(params['end_date']).end_of_day : nil
  status = params['status']
  customer_id = params['customer_id']

  query = Order.all

  query = query.where(:order_date.gte => start_date) if start_date
  query = query.where(:order_date.lte => end_date) if end_date
  query = query.where(status: status) if status
  query = query.where(customer_id: customer_id) if customer_id

  orders = query.to_a
  status 200
  orders.to_json
end
