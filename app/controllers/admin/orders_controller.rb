class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!, :authorize_admin
  before_action :detect_device_variant
  skip_before_action :verify_authenticity_token, only: [:create, :destroy, :change_chart_type]

  def index
    fetch_chart_data
    @orders_in_month = fetch_chart_data.includes(case_category: [:case, :category]).order(created_at: :desc)
    @cases = Case.active_case
  end

  def create
    @case = Case.find params[:case_id]
    @order_detail = OrderDetail.new
    @order_detail.price = quantity*(@case.is_in_sale ? @case.sale_price : @case.price)  - extra_price
    @order_detail.cogs = quantity*@case.capital
    @order_detail.quantity = quantity
    @order_detail.created_at = params[:created_at]
    @order_detail.case_category = CaseCategory.where(case_id: @case.id, category_id: params[:category_id]).first
    @order_detail.revenue = @order_detail.price - @order_detail.cogs
    @order_detail.save!
    fetch_chart_data
    render partial: 'admin/orders/chart', locals: {order_details: @order_details, chart_type: chart_type}
  end

  def destroy
    OrderDetail.find(params[:id]).destroy
    fetch_chart_data
    render partial: 'admin/orders/chart', locals: {order_details: @order_details, chart_type: chart_type}
  end

  def change_chart_type
    fetch_chart_data
    render partial: 'admin/orders/chart', locals: {order_details: @order_details, chart_type: chart_type}
  end

  private

  def extra_price
    params[:extra_price].to_i
  end

  def quantity
    @quantity ||= params[:quantity].to_i == 0 ? 1 : params[:quantity].to_i
  end

  def chart_type
    CHART_TYPE[(params[:chart_type].presence || 1).to_i]
  end

  def fetch_chart_data
    @order_details ||= OrderDetail.from_this_month
  end
end
