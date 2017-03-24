class Lot < ApplicationRecord
  has_many :valorizations
  has_many :variables, through: :valorizations
  belongs_to :project
  validates :sown_at, :material, :hectares, :project_id, presence: true

  def self.columns_chart
    [['Cantidad','1'], ['Costo Mano de Obra','2'], ['Costo por Hectárea','3']]
  end

  def self.chart_values(id)
    case id
      when 1
        {'vAxis' => 'valorizations.amount', 'vAxisLabel' => 'Hectáreas'}
      when 2
        {'vAxis' => 'valorizations.subtotal', 'vAxisLabel' => 'Costo de Mano de Obra'}
      when 3
        {'vAxis' => 'valorizations.unit_cost', 'vAxisLabel' => 'Costo por Hectarea'}
      else
        {'vAxis' => 'valorizations.amount', 'vAxisLabel' => 'Cantidad'}
    end
  end

  def column_chart(hAxis, vAxis)
    self.variables.pluck("#{hAxis}, #{vAxis}")
  end

  def today_values(category)
    self.variables
      .select("variables.id, variables.name, valorizations.unit_cost, valorizations.amount")
      .where(category: category)
      .where("valorizations.assigned_at = ?", Date.today)
  end

  def range_values(category, var_id)
    self.variables
      .where("category": category)
      .where("id": var_id)
      .select("variables.id, variables.name, valorizations.amount, valorizations.unit_cost, valorizations.subtotal, valorizations.assigned_at")
      .order("valorizations.assigned_at ASC")
  end

  #This is a waste, just does the same query twice
  def sum_values(category, var_id)
    range_values(category, var_id)
    .pluck("sum(amount), sum(valorizations.unit_cost), sum(subtotal)")
    .first
  end

  #Returns today's current amount of the given variable as a hash
  #e.g. { name: "VarName", unit_cost: 200, amount: 2, subtotal: 400 }
  #Returns nil if variable does not exist
  def getValue(name)
    var = Variable.find_by_name(name)
    return nil if var.nil?

    value = self.valorizations.find_by(variable: var, assigned_at: Date.today)
    hash = { name: var.name, unit_cost: var.unit_cost, amount: 0, subtotal: 0 }
    unless value.nil?
      hash.merge!({ unit_cost: value.unit_cost, amount: value.amount, subtotal: value.subtotal })
    end

    hash
  end

  #Sets today's current amount of the given variable
  #Returns true on success, otherwise false
  def setValue(name, amount, subtotal)
    var = Variable.find_by_name(name)
    return false if var.nil?

    value = self.valorizations.find_by(variable: var, assigned_at: Date.today)
    unless value.nil?
      value.update_attributes(amount: amount, subtotal: subtotal)
    else
      value = self.valorizations.build(variable: var, amount: amount, subtotal: subtotal)
      value.save
    end
  end

  def values(category)
    variables
      .where(category: category)
      .select("variables.id, variables.name, valorizations.amount, valorizations.unit_cost, valorizations.subtotal, valorizations.assigned_at")
      .where("valorizations.assigned_at": Date.today)
  end
end
