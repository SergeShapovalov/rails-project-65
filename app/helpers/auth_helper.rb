module AuthHelper
  def authorized?
    return false unless session[:user_id]
    auth_user ||= User.find(session[:user_id])
    auth_user.present?
  end
end
