class HomeController < ApplicationController
  def home
    @new_cases = Case.available.order(:created_at).first(4)
    @top_sales_cases = Case.available.top_sales.order(:updated_at).first(4)
  end
end
