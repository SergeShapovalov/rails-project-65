module Web
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.order(created_at: :desc).all
    end

    def new
      @bulletin = Bulletin.new
    end
  end
end
