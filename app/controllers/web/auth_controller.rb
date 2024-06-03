module Web
  class AuthController < ApplicationController
    def request

    end

    def callback
      auth_hash = request.env['omniauth.auth']

      @user = User.find_by(email: auth_hash[:info][:email])
    end
  end
end
