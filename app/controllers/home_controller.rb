class HomeController < ApplicationController
  before_action :detect_device_variant

  def home
    @new_cases = Case.available.order(created_at: :desc).first(8)
    @top_sales_cases = Case.available.top_sales.order(:updated_at).first(8)
  end
end
