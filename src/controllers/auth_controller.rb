module Controllers
  class AuthController < BaseController
    def customer_login
      customer = Customer.where(email: @body['email']).first
      
      if customer && customer.password == @body['password']
        token = JWT.encode(
          { customer_id: customer.id.to_s, exp: 24.hours.from_now.to_i },
          ENV['JWT_SECRET'],
          'HS256'
        )
        
        ResponseData.success({ token: token })
      else
        ResponseData.error('Credenciais inválidas', 401)
      end
    end

    def admin_login
      user = User.where(email: @body['email']).first
      
      if user && user.password == @body['password']
        token = JWT.encode(
          { user_id: user.id.to_s, exp: 24.hours.from_now.to_i },
          ENV['JWT_SECRET'],
          'HS256'
        )
        
        user.user_config.update(last_active: Time.now)
        ResponseData.success({ token: token })
      else
        ResponseData.error('Credenciais inválidas', 401)
      end
    end

    def first_user
      if User.count > 0
        return ResponseData.error('Já existe um usuário cadastrado', 400)
      end

      user = User.new(
        email: @body['email'],
        username: @body['username'],
        password: @body['password'],
        active: true
      )

      if user.save
        UserConfig.create(
          user: user,
          permissions: ['admin'],
          last_active: Time.now
        )
        ResponseData.success({ message: 'Usuário admin criado com sucesso' })
      else
        ResponseData.error(user.errors.full_messages.join(', '))
      end
    end
  end
end 