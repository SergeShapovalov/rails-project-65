# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < ApplicationController
      def index
        @categories = Category.all
      end

      def new
        @category = Category.new
      end

      def edit
        @category = Category.find(params[:id])
      end

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
        @category = Category.find(params[:id])

        if @category.update(category_params)
          redirect_to admin_categories_path, notice: t('.updated_success')
        else
          flash[:alert] = t('.update_failed')
          render :edit
        end
      end

      def destroy
        if Category.find(params[:id]).destroy!
          redirect_to admin_categories_url, notice: t('.deleted_success')
        else
          flash[:alert] = t('.delete_failed')
        end
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
