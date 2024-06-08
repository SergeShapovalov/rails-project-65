# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      def index
        @bulletins = Bulletin.desc_by_created
      end

      def archive
        @bulletin = Bulletin.find params[:id]

        if @bulletin.archive!
          redirect_back_or_to admin_bulletins_path, notice: t('.success')
        else
          redirect_back_or_to admin_bulletins_path, alert: t('.failed')
        end
      end

      def publish
        @bulletin = Bulletin.find params[:id]

        if @bulletin.publish!
          redirect_to admin_root_path, notice: t('.success')
        else
          redirect_to admin_root_path, alert: t('.failed')
        end
      end

      def reject
        @bulletin = Bulletin.find params[:id]

        if @bulletin.reject!
          redirect_to admin_root_path, notice: t('.success')
        else
          redirect_to admin_root_path, alert: t('.failed')
        end
      end
    end
  end
end
