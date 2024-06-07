module Web
  module Admin
    class AdminController < ApplicationController
      def index
        @bulletins = Bulletin.all
      end
    end
  end
end
