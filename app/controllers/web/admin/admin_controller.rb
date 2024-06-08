module Web
  module Admin
    class AdminController < Web::Admin::ApplicationController
      def index
        @bulletins = Bulletin.under_moderation.desc_by_created
      end
    end
  end
end
