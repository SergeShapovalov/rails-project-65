module Web
  class ProfilesController < Web::ApplicationController
    before_action :authorize_user

    def show
      @bulletins = current_user.bulletins.order(created_at: :desc).all
    end
  end
end
