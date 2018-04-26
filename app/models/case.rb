class Case < ApplicationRecord
  has_many :case_categories
  has_many :case_images
end
