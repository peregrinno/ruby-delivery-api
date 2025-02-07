module Controllers
  class ProductController < BaseController
    def index
      products = Product.all.map do |product|
        {
          id: product.id.to_s,
          name: product.name,
          value: product.value
        }
      end
      
      ResponseData.success(products)
    end

    def create
      authenticate_user!
      
      product = Product.new(
        name: @body['name'],
        value: @body['value']
      )

      if product.save
        ResponseData.success({ message: 'Produto criado com sucesso' })
      else
        ResponseData.error(product.errors.full_messages.join(', '))
      end
    end

    def update(product_id)
      result = authenticate_user!
      return result if result.is_a?(Hash) && result[:status]
      
      begin
        return json_halt(400, 'ID do produto não fornecido') if product_id.nil? || product_id.empty?
        
        product = Product.find(product_id)
        if product.update(@body.slice('name', 'value'))
          ResponseData.success({ message: 'Produto atualizado com sucesso' })
        else
          ResponseData.error(product.errors.full_messages.join(', '))
        end
      rescue Mongoid::Errors::DocumentNotFound
        json_halt(404, 'Produto não encontrado')
      rescue => e
        json_halt(500, 'Erro interno ao atualizar produto')
      end
    end

    def delete
      authenticate_user!
      product = Product.find(@params['id'])
      
      if product.destroy
        ResponseData.success({ message: 'Produto removido com sucesso' })
      else
        ResponseData.error('Erro ao remover produto')
      end
    end
  end 
end
