class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!, :authorize_admin
  before_action :detect_device_variant
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    fetch_chart_data
    @cases = Case.all
  end

  def create
    @case = Case.find params[:case_id]
    @order_detail = OrderDetail.new
    @order_detail.price = quantity*(@case.is_in_sale ? @case.sale_price : @case.price)
    @order_detail.cogs = quantity*@case.capital
    @order_detail.quantity = quantity
    @order_detail.created_at = params[:created_at]
    @order_detail.case_category = CaseCategory.where(case_id: @case.id, category_id: params[:category_id]).first
    @order_detail.revenue = quantity*(@order_detail.price - @order_detail.cogs)
    @order_detail.save!
    fetch_chart_data
    render partial: 'admin/orders/chart', locals: {order_details: @order_details}
  end

  private

  def quantity
    @quantity ||= params[:quantity].to_i == 0 ? 1 : params[:quantity].to_i
  end

  def fetch_chart_data
    @order_details ||= OrderDetail.from_this_month
  end
end
