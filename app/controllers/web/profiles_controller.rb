# frozen_string_literal: true

module Web
  class ProfilesController < Web::ApplicationController
    before_action :authorize_user

    def show
      @query = current_user.bulletins.ransack(params[:q])
      @bulletins = @query.result.desc_by_created.page(params[:page])
    end
  end
end
