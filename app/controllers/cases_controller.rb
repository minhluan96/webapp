class CasesController < ApplicationController
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Shop", :cases_path
  skip_before_action :verify_authenticity_token, only: [:filter_cases]
  before_action :detect_device_variant, only: [:show, :index, :tempered_glass]

  def tempered_glass
    session[:mobile_previous_url] = request.fullpath
    @per_page = browser.device.mobile? ? 5 : 9
    load_cases
  end

  def show
    @case = Case.includes([:case_images, case_categories: [:category]]).find(params[:id])
    add_breadcrumb @case.name
    session[:previous_url] = request.fullpath
    @back_url = session[:mobile_previous_url] || root_path
  end

  def index
    session[:mobile_previous_url] = request.fullpath
    @per_page = browser.device.mobile? ? 5 : 9
    load_cases
  end

  def filter_cases
    @per_page = 9
    load_cases
    render partial: 'filtered_products', locals: {cases: @cases }
  end

  def mobile_filter_cases
    @per_page = 5
    load_cases
    render partial: 'mobile_filtered_products', locals: {cases: @cases}
  end

  private

  def page
    page = params[:page].to_i
    page == 0 ? 1 : page
  end

  def cases
    if @category_id == 0
      ids = CaseCategory.active_category.where(category_id: Category.case.pluck(:id)).pluck :case_id
      result = Case.active_case.where(id: ids)
    elsif @category_id == -1
      ids = CaseCategory.active_category.where(category_id: Category.tempered_glass.pluck(:id)).pluck :case_id
      result = Case.active_case.where(id: ids)
    else
      ids = CaseCategory.active_category.where(category_id: @category_id).pluck :case_id
      result = Case.active_case.where(id: ids)
    end
    result = result.where(is_available: @is_available) if @is_available
    result = result.where(is_in_sale: @is_sale) if @is_sale
    case @order
    when 'price'
      result.order("CASE
                      WHEN is_in_sale = true then sale_price
                      WHEN is_in_sale = false then price
                    END, id").page(page).per(@per_page)
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
    @categories = Category.case.order(:name)
    @tempered_glass_categories = Category.tempered_glass.order(:name)
    @order = params[:order] || 'created_at'
    @cases = cases
    @available_orders = build_orders
  end
end
