class Order < ApplicationRecord
  has_many :order_details
  paginates_per 10
end
