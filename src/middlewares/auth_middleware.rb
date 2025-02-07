module AuthMiddleware
  def authenticate_user!
    auth_header = @request.env['HTTP_AUTHORIZATION']

    if auth_header
      token = auth_header.split(' ').last
      
      begin
        payload = JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')[0]
        
        @current_user = User.find(payload['user_id'])
        
        return @current_user if @current_user
      rescue JWT::DecodeError => e
        return json_halt(401, 'Token inválido')
      rescue Mongoid::Errors::DocumentNotFound => e
        return json_halt(401, 'Token inválido')
      rescue => e
        return json_halt(401, 'Token inválido')
      end
    end
    json_halt(401, 'Token não fornecido')
  end

  def authenticate_customer!
    auth_header = @request.env['HTTP_AUTHORIZATION']
    if auth_header
      token = auth_header.split(' ').last
      begin
        payload = JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')[0]
        @current_customer = Customer.find(payload['customer_id'])
        return @current_customer if @current_customer
      rescue JWT::DecodeError, Mongoid::Errors::DocumentNotFound
        return json_halt(401, 'Token inválido')
      end
    end
    json_halt(401, 'Token não fornecido')
  end
end 