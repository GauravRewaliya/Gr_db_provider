class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  allow_browser versions: :modern

  def authenticate_admin_user!
    unless current_user&.is_admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
