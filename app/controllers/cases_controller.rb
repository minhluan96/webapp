class CasesController < ApplicationController
  def show

  end

  def index
    @category_id = params[:category_id].to_i
    @categories = Category.all.order(:name)
    @order = order
    @cases = cases.order(@order)
    @available_orders = build_orders
  end

  private
  def page
    page = params[:page].to_i
    page == 0 ? 1 : page
  end

  def order
    params[:order]
  end

  def cases
    if @category_id == 0
      Case.all.page(page)
    else
      ids = CaseCategory.where(category_id: @category_id).pluck :case_id
      Case.where(id: ids).page(page)
    end
  end

  def build_orders
    {
        'created_at' => 'Newest',
        'price' => 'Price',
        'name' => 'Name A-Z'
    }
  end
end
