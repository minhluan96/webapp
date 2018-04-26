class CaseCategory < ApplicationRecord
  belongs_to :case
  belongs_to :category
end
