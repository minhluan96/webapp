class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_class
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_page
  rescue_from CanCan::AccessDenied, with: :render_access_denied_page

  def current_class(test_path)
    return 'active' if request.path == test_path
    ''
  end

  private
  def render_not_found_page
    render 'error/error_404_page'
  end

  def render_access_denied_page
    render 'error/error_403_page'
  end

  def authorize_admin
    raise CanCan::AccessDenied unless current_user.is_admin?
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
