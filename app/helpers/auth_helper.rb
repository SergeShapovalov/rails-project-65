module AuthHelper
  def authorized?
    auth_user ||= User.find(session[:user_id])
    auth_user.present?
  end
end
