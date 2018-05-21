class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_class, :build_url_params
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_page
  rescue_from CanCan::AccessDenied, with: :render_access_denied_page

  def current_class(test_path)
    return 'active' if request.path == test_path
    ''
  end

  def build_url_params(new_params = nil)
    result = {
        category_id: @category_id,
        order: @order,
        is_available: @is_available,
        is_sale: @is_sale
    }
    return result if new_params.blank?
    k, v = new_params.first
    result[k] = v
    result
  end

  private

  def detect_device_variant
    request.variant = :phone if browser.device.mobile?
  end

  def render_not_found_page
    render 'error/error_404_page'
  end

  def render_access_denied_page
    render 'error/error_403_page'
  end

  def authorize_admin
    authorize! :manage, :all
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
