module AuthHelper
  def authorized?
    return false unless session[:user_id]
    auth_user ||= User.find_by_id(session[:user_id])
    auth_user.present? if auth_user
  end
end
