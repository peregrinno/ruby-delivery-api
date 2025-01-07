require 'jwt'

module AuthHelper
  def authenticate!
    header = request.env['HTTP_AUTHORIZATION']
    if header.nil? || !header.start_with?('Bearer ')
      halt 401, { error: 'Token ausente ou inválido' }.to_json
    end

    token = header.split(' ').last

    begin
      payload = JWT.decode(token, 'secret_key', true, algorithm: 'HS256').first
      @current_user = Customer.find(payload['customer_id'])
    rescue JWT::DecodeError
      halt 401, { error: 'Token inválido ou expirado' }.to_json
    end
  end
end
