module Web
  class BulletinsController < Web::ApplicationController
    def index
      @bulletins = Bulletin.order(created_at: :desc).all
    end

    def new
      @bulletin = current_user.bulletin.build
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def create
      @bulletin = current_user.bulletin.build(bulletin_params)
      @bulletin.user_id = session[:user_id]

      if @bulletin.save
        redirect_to bulletin_path @bulletin, notice: t('.success')
      else
        redirect_to new_bulletin_path, notice: t('.failed')
      end
    end

    def edit
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def update
      @bulletin = Bulletin.find params[:id]
      authorize @bulletin

      if @bulletin.update(bulletin_params)
        redirect_to profile_path, notice: t('.success')
      else
        flash.now[:failure] = t('.failure')
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
