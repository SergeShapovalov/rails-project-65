module Web
  module Admin
    class ApplicationController < Web::ApplicationController
      before_action :authorize_admin
    end
  end
end
