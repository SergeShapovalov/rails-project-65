module Web
  class AuthController < ApplicationController
    def callback
      auth_hash = request.env['omniauth.auth']
      user_info = auth_hash['info']

      user = User.find_or_initialize_by(email: user_info[:email].downcase)
      user.name = user_info[:name]

      if user.save
        sign_in(user.id)
        flash[:success] = t('.success')
      else
        flash[:failure] = t('.failed')
      end

      redirect_to root_path
    end

    private

    def sign_in(user_id)
      session['user_id'] = user_id
    end
  end
end
