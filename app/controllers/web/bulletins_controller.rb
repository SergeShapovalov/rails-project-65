module Web
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.order(created_at: :desc).all
    end

    def new
      @bulletin = Bulletin.new
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def create
      @bulletin = Bulletin.build(bulletin_params)
      @bulletin.user_id = session[:user_id]

      if @bulletin.save
        redirect_to bulletin_path @bulletin, notice: t('.success')
      else
        redirect_to new_bulletin_path, notice: t('.failed')
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
