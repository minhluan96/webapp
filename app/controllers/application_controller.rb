class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_class
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_home_page
  rescue_from CanCan::AccessDenied, with: :redirect_to_home_page

  def current_class(test_path)
    return 'active' if request.path == test_path
    ''
  end

  private
  def redirect_to_home_page
    redirect_to root_path
  end

  def authorize_admin
    raise CanCan::AccessDenied unless current_user.is_admin?
  end
end
