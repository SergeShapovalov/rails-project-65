module Web
  class BulletinsController < Web::ApplicationController
    before_action :authorize_user, only: %i[new create edit update moderate archive]

    def index
      @query = Bulletin.ransack(params[:q])
      @bulletins = @query.result.published.desc_by_created.page(params[:page]).per(12)
      @categories = Category.all
    end

    def new
      @bulletin = current_user.bulletins.build
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)
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
        flash.now[:failure] = t('.failed')
        render :edit, status: :unprocessable_entity
      end
    end

    def moderate
      @bulletin = Bulletin.find params[:id]
      authorize @bulletin

      if @bulletin.moderate!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failed')
      end
    end

    def archive
      @bulletin = Bulletin.find params[:id]
      authorize @bulletin

      if @bulletin.archive!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failed')
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
