class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :ensure_not_pending

  def ensure_not_pending
    if current_user
      if current_user.role == "pending"
        sign_out(current_user)
        redirect_to new_user_session_path, alert: "Your account must be confirmed by an admin of the organization before you can sign in."
      end
    end
  end

  def current_organization
    current_user.organization
  end
end
