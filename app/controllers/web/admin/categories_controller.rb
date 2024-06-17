# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < Web::Admin::ApplicationController
      before_action :find_category, only: %i[edit update destroy]

      def index
        @categories = Category.all
      end

      def new
        @category = Category.new
      end

      def edit; end

      def create
        @category = Category.new(category_params)

        if @category.save
          redirect_to admin_categories_path, notice: t('.created_success')
        else
          flash[:alert] = t('.create_failed')
          render :new
        end
      end

      def update
        if @category.update(category_params)
          redirect_to admin_categories_path, notice: t('.updated_success')
        else
          flash[:alert] = t('.update_failed')
          render :edit
        end
      end

      def destroy
        if @category.bulletins.exists?
          redirect_to admin_categories_path, alert: t('.has_bulletins')
        elsif @category.destroy!
          redirect_to admin_categories_path, notice: t('.success')
        else
          flash[:alert] = t('.delete_failed')
        end
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end

      def find_category
        @category = Category.find(params[:id])
      end
    end
  end
end
