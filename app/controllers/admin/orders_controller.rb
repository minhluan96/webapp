class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!, :authorize_admin
  before_action :detect_device_variant

  def index
    @order_details = OrderDetail.from_this_month.group_by_day(:created_at)
    @cases = Case.all
  end
end
