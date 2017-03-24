class Variable < ApplicationRecord
  has_many :valorizations
  has_many :lots, through: :valorizations
  belongs_to :category

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.measurement_units
    ["Tonelada(s)", "Kilogramo(s)", "Libra(s)", "Hectare(s)", "Metro(s)", "Pulgada(s)", "Pie(s)", "Yarda(s)", "Pinta(s)", "Galon(es)", "Litro(s)"]
  end
end
