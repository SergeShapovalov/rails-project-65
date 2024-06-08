module Web
  class ProfilesController < Web::ApplicationController
    before_action :authorize_user

    def show
      @bulletins = current_user.bulletins.desc_by_created.all
    end
  end
end
