class Category < ApplicationRecord
  has_many :case_categories
  scope :case, -> { where(is_tempered_glass: false) }
  scope :tempered_glass, -> { where(is_tempered_glass: true) }

end
