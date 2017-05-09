class Lot < ApplicationRecord
  has_many :valorizations
  has_many :variables, through: :valorizations
  belongs_to :project
  validates :sown_at, :material, :hectares, :project_id, presence: true

  def self.columns_chart
    [['Cantidad','1'], ['Costo Mano de Obra','2'], ['Costo por Hectárea por Mano de Obra','3'], ['Costo por Hectárea por Insumo','4']]
  end

  def self.chart_values(id)
    case id
      when 1
        {'vAxis' => 'valorizations.amount', 'vAxisLabel' => 'Hectáreas'}
      when 2
        {'vAxis' => 'valorizations.cost_mano', 'vAxisLabel' => 'Costo por Mano de Obra'}
      when 3
        {'vAxis' => 'valorizations.unit_cost_mano', 'vAxisLabel' => 'Costo por Hectárea por Mano de Obra'}
      when 4
        {'vAxis' => 'valorizations.unit_cost_insumo', 'vAxisLabel' => 'Costo por Hectárea por Insumo'}
      when 5
        {'vAxis' => 'valorizations.cost_mano', 'vAxisLabel' => 'Costo por Insumo'}
      else
        {'vAxis' => 'valorizations.amount', 'vAxisLabel' => 'Cantidad'}
    end
  end

  def column_chart(hAxis, vAxis)
    self.variables.pluck("#{hAxis}, #{vAxis}")
  end

  def today_values(category)
    self.variables
      .select("variables.id, variables.name, valorizations.unit_cost_mano, valorizations.amount, valorizations.unit_cost_insumo")
      .where(category: category)
      .where("valorizations.assigned_at = ?", Date.today)
  end

  def range_values(category, var_id)
    self.variables
      .where("category": category)
      .where("id": var_id)
      .select("variables.id, variables.name, valorizations.amount, valorizations.unit_cost_mano, valorizations.cost_mano, valorizations.unit_cost_insumo, valorizations.cost_insumo, valorizations.assigned_at")
      .order("valorizations.assigned_at ASC")
  end

  #This is a waste, just does the same query twice
  def sum_values(category, var_id)
    range_values(category, var_id)
    .pluck("sum(amount), sum(valorizations.unit_cost_mano), sum(cost_mano), sum(valorizations.unit_cost_insumo), sum(cost_insumo)")
    .first
  end

  #Returns today's current amount of the given variable as a hash
  #e.g. { name: "VarName", unit_cost_mano: 200, unit_cost_insumo: 300, amount: 2, cost_mano: 400, cost_insumo: 600 }
  #Returns nil if variable does not exist
  def getValue(name)
    var = Variable.find_by_name(name)
    return nil if var.nil?

    value = self.valorizations.find_by(variable: var, assigned_at: Date.today)
    hash = { name: var.name, unit_cost_mano: var.unit_cost_mano, unit_cost_insumo: var.unit_cost_insumo, amount: 0, cost_mano: 0, cost_insumo: 0 }
    unless value.nil?
      hash.merge!({ unit_cost_mano: value.unit_cost_mano, unit_cost_insumo: value.unit_cost_insumo, amount: value.amount, cost_mano: value.cost_mano, cost_insumo: value.cost_insumo })
    end

    hash
  end

  #Sets today's current amount of the given variable
  #Returns true on success, otherwise false
  def setValue(name, amount, cost_mano, cost_insumo)
    var = Variable.find_by_name(name)
    return false if var.nil?

    value = self.valorizations.find_by(variable: var, assigned_at: Date.today)
    unless value.nil?
      value.update_attributes(amount: amount, cost_mano: cost_mano, cost_insumo: cost_insumo)
    else
      value = self.valorizations.build(variable: var, amount: amount, cost_mano: cost_mano, cost_insumo: cost_insumo)
      value.save
    end
  end

  def values(category)
    variables
      .where(category: category)
      .select("variables.id, variables.name, valorizations.amount, valorizations.unit_cost_mano, valorizations.cost_mano, valorizations.unit_cost_insumo, valorizations.assigned_at")
      .where("valorizations.assigned_at": Date.today)
  end
end
