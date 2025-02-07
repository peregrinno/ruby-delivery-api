module Controllers
  class UserController < BaseController
    def index
      authenticate_user!
      users = User.all.map do |user|
        {
          id: user.id.to_s,
          email: user.email,
          username: user.username,
          active: user.active,
          permissions: user.user_config&.permissions || []
        }
      end
      
      ResponseData.success(users)
    end

    def create
      authenticate_user!
      
      user = User.new(
        email: @body['email'],
        username: @body['username'],
        password: @body['password'],
        active: true
      )

      if user.save
        UserConfig.create(
          user: user,
          permissions: @body['permissions'] || [],
          last_active: Time.now
        )
        ResponseData.success({ message: 'Usuário criado com sucesso' })
      else
        ResponseData.error(user.errors.full_messages.join(', '))
      end
    end

    def update
      authenticate_user!
      user = User.find(@params['id'])
      
      update_params = {}
      update_params[:email] = @body['email'] if @body['email']
      update_params[:username] = @body['username'] if @body['username']
      update_params[:password] = @body['password'] if @body['password']
      update_params[:active] = @body['active'] unless @body['active'].nil?

      if user.update(update_params)
        if @body['permissions']
          user.user_config.update(permissions: @body['permissions'])
        end
        ResponseData.success({ message: 'Usuário atualizado com sucesso' })
      else
        ResponseData.error(user.errors.full_messages.join(', '))
      end
    end

    def delete
      authenticate_user!
      user = User.find(@params['id'])
      
      if user.destroy
        ResponseData.success({ message: 'Usuário removido com sucesso' })
      else
        ResponseData.error('Erro ao remover usuário')
      end
    end
  end 
end