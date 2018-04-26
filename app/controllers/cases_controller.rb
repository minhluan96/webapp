class CasesController < ApplicationController
  def show

  end

  def index
    @cases = Case.page(page)
  end

  private
  def page
    params[:page] || 1
  end
end
