class CasesController < ApplicationController
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Shop", :cases_path
  skip_before_action :verify_authenticity_token, only: :filter_cases
  before_action :detect_device_variant, only: [:show, :index]

  def show
    @case = Case.includes([:case_images, :case_categories]).find(params[:id])
    add_breadcrumb @case.name
    session[:previous_url] = request.fullpath
  end

  def index
    load_cases
  end

  def filter_cases
    load_cases
    render partial: 'filtered_products', locals: {cases: @cases, available_orders: @available_orders, category_id: @category_id}
  end

  def mobile_filter_cases
    load_cases
    render partial: 'mobile_filtered_products', locals: {cases: @cases}
  end

  private

  def page
    page = params[:page].to_i
    page == 0 ? 1 : page
  end

  def cases
    @per_page = browser.device.mobile? ? 5 : 9
    if @category_id == 0
      result = Case.all
    else
      ids = CaseCategory.where(category_id: @category_id).pluck :case_id
      result = Case.where(id: ids)
    end
    result = result.where(is_available: @is_available) if @is_available
    result = result.where(is_in_sale: @is_sale) if @is_sale
    case @order
    when 'price'
      result.order(is_in_sale: :desc, sale_price: :asc, price: :asc).page(page).per(@per_page)
    when 'created_at'
      result.order(created_at: :desc).page(page).per(@per_page)
    else
      result.order(:name).page(page).per(@per_page)
    end
  end

  def build_orders
    {
        'name' => 'Name A-Z',
        'created_at' => 'Newest',
        'price' => 'Price'
    }
  end

  def load_cases
    @is_available = params[:is_available] == "true"
    @is_sale = params[:is_sale] == "true"
    @category_id = params[:category_id].to_i
    @categories = Category.all.order(:name)
    @order = params[:order] || 'price'
    @cases = cases
    @available_orders = build_orders
  end
end
