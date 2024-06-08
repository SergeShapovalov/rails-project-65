module Web
  class ApplicationController < ApplicationController
    include Pundit::Authorization
    include AuthConcern

    rescue_from Pundit::NotAuthorizedError, with: :authorize_error

    def authorize
      unless authorized?
        redirect_to root_path, alert: t('.not_authorized')
      end
    end

    def authorize_error
      redirect_to root_path, alert: t('.authorize_error')
    end

    def authorize_admin
      unless is_admin?
        redirect_to root_path, alert: t('.access_denied')
      end
    end
  end
end
