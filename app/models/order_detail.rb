class OrderDetail < ApplicationRecord
  belongs_to :case_category, class_name: 'CaseCategory', foreign_key: 'case_categories_id'
  belongs_to :order, optional: true

  scope :from_this_month, lambda {where(created_at: Time.now.beginning_of_month..(Time.now.end_of_month))}
end
