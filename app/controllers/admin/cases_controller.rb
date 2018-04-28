class Admin::CasesController < ApplicationController
  before_action :authenticate_user!, :authorize_admin


  def show

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
end
