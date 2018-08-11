class Admin::CasesController < ApplicationController
  before_action :authenticate_user!, :authorize_admin
  skip_before_action :verify_authenticity_token, only: [:get_orders, :categories]

  def new
    @case = Case.new
  end

  def create
    ActiveRecord::Base.transaction do
      @case = Case.new
      update_case_with_params
      update_image_and_category
    end
    redirect_to admin_cases_path
  end

  def edit
    @case = Case.includes([:case_images, case_categories: [:category]]).find(params[:id])
  end

  def update
    @case = Case.find(params[:id])
    ActiveRecord::Base.transaction do
      update_case_with_params
      @case.case_images.destroy_all
      @case.case_categories.update_all(active: false)
      update_image_and_category
    end
    redirect_to session[:previous_url] || admin_cases_path
  end

  def index
    @cases = Case.all
    session.delete(:previous_url)
  end

  def destroy
    Case.find(params[:id]).destroy
    redirect_to admin_cases_path
  end

  def toggle_top_sales
    @case = Case.find(params[:id])
    @case.update_attribute(:is_top_sales, !@case.is_top_sales)
  end

  def toggle_is_available
    @case = Case.find(params[:id])
    @case.update_attribute(:is_available, !@case.is_available)
  end

  def get_orders
    @case = Case.includes(case_categories: [:order_details]).find params[:case_id]
    render partial: 'orders', locals: {pill_case: @case}
  end

  def categories
    @case = Case.includes(case_categories: [:category]).find(params[:case_id])
    render partial: 'categories', locals: {categories: @case.case_categories.map(&:category), case_id: @case.id}
  end

  private

  def case_params
    params[:case]
  end

  def image_urls
    @image_urls ||= params[:image].reject(&:blank?)
  end

  def case_categories
    params[:case][:category]
  end

  def update_case_with_params
    @case.name = case_params[:name]
    @case.price = case_params[:price]
    @case.description = case_params[:description]
    @case.is_in_sale = case_params[:is_in_sale] == 'on'
    @case.sale_price = case_params[:sale_price]
    @case.capital = case_params[:capital]
    @case.image = image_urls.shift
    @case.save!
  end

  def update_image_and_category
    image_urls.each do |case_image|
      CaseImage.create(case_id: @case.id, image_url: case_image)
    end
    case_categories.each do |k, v|
      case_category = CaseCategory.where(case_id: @case.id, category_id: k).first_or_initialize
      case_category.quantity = v.to_i
      case_category.active = v.present?
      case_category.save!
    end
  end
end
