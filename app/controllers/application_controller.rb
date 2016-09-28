class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_not_authorized
  	flash[:warning] = "You are not authorized to perform this action."
    if signed_in?
      redirect_to request.referrer || admin_dashboard_path
    else
      redirect_to  root_path
    end
  end
end
