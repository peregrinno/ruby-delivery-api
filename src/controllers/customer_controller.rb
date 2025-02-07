module Controllers
  class CustomerController < BaseController
    def register
      customer = Customer.new(
        email: @body['email'],
        name: @body['name'],
        password: @body['password'],
        active: true
      )

      if customer.save
        ResponseData.success({ message: 'Cliente registrado com sucesso' })
      else
        ResponseData.error(customer.errors.full_messages.join(', '))
      end
    end

    def create_order
      customer = authenticate_customer!
      
      order = Order.new(
        customer: customer,
        total: 0,
        date: Time.now
      )

      total = 0
      order_details = []

      @body['items'].each do |item|
        product = Product.find(item['product_id'])
        subtotal = product.value * item['quantity']
        total += subtotal
        
        order_details << OrderDetail.new(
          product: product,
          sub_total: subtotal
        )
      end

      order.total = total
      
      if order.save
        order_details.each do |detail|
          detail.order = order
          detail.save
        end
        
        ResponseData.success({ message: 'Pedido criado com sucesso', order_id: order.id })
      else
        ResponseData.error(order.errors.full_messages.join(', '))
      end
    end
  end
end 