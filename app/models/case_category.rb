class CaseCategory < ApplicationRecord
  belongs_to :case
  belongs_to :category
  has_many :order_details, class_name: 'OrderDetail', foreign_key: "case_categories_id"

  scope :active_category, -> {where(active: true)}
end
