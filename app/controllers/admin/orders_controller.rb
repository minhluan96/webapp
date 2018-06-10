class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!, :authorize_admin

  def index
    @orders = Order.includes(:order_details).order(id: :desc).page(page)
  end

  private

  def page
    params[:page] || 1
  end
end
