# frozen_string_literal: true

module Web
  module Admin
    class AdminController < Web::Admin::ApplicationController
      def index
        @bulletins = Bulletin.under_moderation.desc_by_created.page(params[:page])
      end
    end
  end
end
