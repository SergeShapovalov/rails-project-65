# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      before_action :find_bulletin, only: %i[archive publish reject]

      def index
        @query = Bulletin.ransack(params[:q])
        @bulletins = @query.result.desc_by_created.page(params[:page])
      end

      def archive
        if @bulletin.may_archive?
          @bulletin.archive!
          redirect_back_or_to admin_bulletins_path, notice: t('.success')
        else
          redirect_back_or_to admin_bulletins_path, alert: t('.failed')
        end
      end

      def publish
        if @bulletin.may_publish?
          @bulletin.publish!
          redirect_to admin_root_path, notice: t('.success')
        else
          redirect_to admin_root_path, alert: t('.failed')
        end
      end

      def reject
        if @bulletin.may_reject?
          @bulletin.reject!
          redirect_to admin_root_path, notice: t('.success')
        else
          redirect_to admin_root_path, alert: t('.failed')
        end
      end

      private

      def find_bulletin
        @bulletin = Bulletin.find(params[:id])
      end
    end
  end
end
