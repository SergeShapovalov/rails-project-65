# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    before_action :authorize_user, only: %i[new create edit update moderate archive]
    before_action :get_bulletin, only: %i[show edit update moderate archive]
    before_action :authorize_bulletin, only: %i[edit update moderate archive]

    def index
      @query = Bulletin.ransack(params[:q])
      @bulletins = @query.result.published.desc_by_created.page(params[:page]).per(12)
      @categories = Category.all
    end

    def new
      @bulletin = current_user.bulletins.build
    end

    def show; end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)
      @bulletin.user_id = session[:user_id]

      if @bulletin.save
        redirect_to bulletin_path @bulletin, notice: t('.success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @bulletin.update(bulletin_params)
        redirect_to profile_path, notice: t('.success')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def moderate
      if @bulletin.may_moderate?
        @bulletin.moderate!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failed')
      end
    end

    def archive
      if @bulletin.may_archive?
        @bulletin.archive!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failed')
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end

    def get_bulletin
      @bulletin = Bulletin.find params[:id]
    end

    def authorize_bulletin
      authorize @bulletin
    end
  end
end
