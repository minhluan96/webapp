class Case < ApplicationRecord
  has_many :case_categories
  has_many :case_images

  scope :available, -> { where(is_available: true) }
  scope :top_sales, -> { where(is_top_sales: true) }

  paginates_per 12

  def formatted_price
    ActiveSupport::NumberHelper.number_to_currency(price, unit: "VNĐ", delimiter: ",", format: "%n %u", precision: 0)
  end
end
