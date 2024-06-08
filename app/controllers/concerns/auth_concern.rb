# frozen_string_literal: true

module AuthConcern
  extend ActiveSupport::Concern

  def authorized?
    auth_user&.present?
  end

  def is_admin?
    auth_user&.admin?
  end

  def auth_user
    if session[:user_id]
      User.find_by_id(session[:user_id])
    end
  end

  def sign_out()
    session.delete(:user_id)
    session.clear
    redirect_to root_path, notice: t('.success')
  end

  def sign_in(user_id)
    session['user_id'] = user_id
  end
end
