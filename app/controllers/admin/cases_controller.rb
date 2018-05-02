class Admin::CasesController < ApplicationController
  before_action :authenticate_user!, :authorize_admin

  def new
    @case = Case.new
  end

  def show

  end

  def create
    ActiveRecord::Base.transaction do
      @case = Case.new
      update_case_with_params
      image_urls.each do |case_image|
        CaseImage.create(case_id: @case.id, image_url: case_image)
      end
      case_categories.each do |k, v|
        CaseCategory.create(case_id: @case.id, category_id: k, quantity: v)
      end
    end
    redirect_to admin_cases_path
  end

  def edit
    @case = Case.includes([:case_categories, :case_images]).find(params[:id])
  end

  def update
    @case = Case.find(params[:id])
    ActiveRecord::Base.transaction do
      update_case_with_params
      @case.case_images.destroy_all
      image_urls.each do |case_image|
        CaseImage.create(case_id: @case.id, image_url: case_image)
      end

      @case.case_categories.destroy_all
      case_categories.each do |k, v|
        CaseCategory.create(case_id: @case.id, category_id: k, quantity: v)
      end
    end
    redirect_to admin_cases_path
  end

  def index
    @cases = Case.includes(:case_categories).all
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
    @case.image = image_urls.shift
    @case.save!
  end
end