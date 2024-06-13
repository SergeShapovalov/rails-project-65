# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include Pundit::Authorization
    include AuthConcern

    rescue_from Pundit::NotAuthorizedError, with: :authorize_error

    def authorize_user
      return if authorized?

      redirect_to root_path, alert: t('.not_authorized')
    end

    def authorize_error
      redirect_to root_path, alert: t('.authorize_error')
    end

    def authorize_admin
      return if is_admin?

      redirect_to root_path, alert: t('.access_denied')
    end
  end
end
