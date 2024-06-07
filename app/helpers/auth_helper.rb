module AuthHelper
  def authorized?
    user = auth_user
    user && user.present?
  end

  def is_admin?
    user = auth_user
    user && user.admin?
  end

  private

  def auth_user
    return nil unless session[:user_id]
    auth_user ||= User.find_by_id(session[:user_id])
  end
end
