module Controllers
  class OrderController < BaseController
    def index
      authenticate_user!
      orders = Order.all.map do |order|
        {
          id: order.id.to_s,
          customer: {
            id: order.customer.id.to_s,
            name: order.customer.name,
            email: order.customer.email
          },
          total: order.total,
          status: order.status,
          date: order.date,
          items: order.order_details.map do |detail|
            {
              product: {
                id: detail.product.id.to_s,
                name: detail.product.name
              },
              sub_total: detail.sub_total
            }
          end
        }
      end
      
      ResponseData.success(orders)
    end

    def update_status(order_id)
      
      result = authenticate_user!
      return result if result.is_a?(Hash) && result[:status]

      
      begin
        return json_halt(400, 'ID do pedido não fornecido') if order_id.nil? || order_id.empty?
        return json_halt(400, 'Status não fornecido') if @body['status'].nil?
        
        order = Order.find(order_id)
        
        if order.update(status: @body['status'])
          ResponseData.success({ message: 'Status do pedido atualizado com sucesso' })
        else
          ResponseData.error(order.errors.full_messages.join(', '))
        end
      rescue Mongoid::Errors::DocumentNotFound
        json_halt(404, 'Pedido não encontrado')
      rescue => e
        json_halt(500, 'Erro interno ao atualizar status do pedido')
      end
    end

    def customer_orders
      customer = authenticate_customer!
      orders = Order.where(customer: customer).map do |order|
        {
          id: order.id.to_s,
          total: order.total,
          status: order.status,
          date: order.date,
          items: order.order_details.map do |detail|
            {
              product: {
                name: detail.product.name
              },
              sub_total: detail.sub_total
            }
          end
        }
      end
      
      ResponseData.success(orders)
    end
  end 
end