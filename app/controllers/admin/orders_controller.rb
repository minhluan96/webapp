class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!, :authorize_admin
  before_action :detect_device_variant
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @order_details = OrderDetail.from_this_month.group_by_day(:created_at)
    @cases = Case.all
  end

  def create
    @case = Case.find params[:case_id]
    @order_detail = OrderDetail.new
    @order_detail.price = @case.is_in_sale ? @case.sale_price : @case.price
    @order_detail.cogs = @case.capital
    @order_detail.quantity = 1
    @order_detail.created_at = params[:created_at]
    @order_detail.case_category = CaseCategory.where(case_id: @case.id, category_id: params[:category_id]).first
    @order_detail.revenue = @order_detail.price - @order_detail.cogs
    @order_detail.save!
    @order_details = OrderDetail.from_this_month.group_by_day(:created_at)
    render json: [{name: 'Doanh Thu', data: @order_details.sum(:price)}, {name: 'Lợi Nhuận', data: @order_details.sum(:revenue)}].to_json
  end
end
