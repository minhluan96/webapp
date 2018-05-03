class Case < ApplicationRecord
  has_many :case_categories, dependent: :destroy
  has_many :case_images, dependent: :destroy
  has_many :case_videos, dependent: :destroy

  scope :available, -> {where(is_available: true)}
  scope :top_sales, -> {where(is_top_sales: true)}
  scope :next, -> (id) {where("id > ?", id)}
  scope :previous, -> (id) {where("id < ?", id)}

  include ActiveSupport::NumberHelper

  paginates_per 9

  def formatted_price
    number_to_currency(price, unit: "VNĐ", delimiter: ",", format: "%n %u", precision: 0)
  end

  def formatted_sale_price
    number_to_currency(sale_price, unit: "VNĐ", delimiter: ",", format: "%n %u", precision: 0)
  end

  def next
    Case.next(self.id).first
  end

  def previous
    Case.previous(self.id).last
  end
end
