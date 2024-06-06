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
      @bulletin = current_user.bulletins.build(bulletin_params)

      if @bulletin.save
        redirect_to bulletin_path @bulletin, notice: t('.success')
      else
        flash.now[:failure] = t('.failed')
        render :new
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
