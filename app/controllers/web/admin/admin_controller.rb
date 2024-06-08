module Web
  module Admin
    class AdminController < Web::Admin::ApplicationController
      def index
        @bulletins = Bulletin.all
      end
    end
  end
end
