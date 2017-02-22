class Variable < ApplicationRecord
  belongs_to :category
  validates :unit_cost, :name, presence: true
end
