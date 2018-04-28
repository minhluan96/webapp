class Admin::CasesController < ApplicationController
  before_action :authenticate_user!, :authorize_admin

  def index
  end
end
