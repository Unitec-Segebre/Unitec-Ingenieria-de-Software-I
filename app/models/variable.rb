class Variable < ApplicationRecord
  has_many :valorizations
  has_many :lots, through: :valorizations
  belongs_to :category

  validates :unit_cost, :name, presence: true
  validates :name, uniqueness: true
end
