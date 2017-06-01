  class Lot < ApplicationRecord
  has_many :valorizations
  has_many :variables, through: :valorizations
  belongs_to :project
  validates :sown_at, :material, :hectares, :project_id, presence: true

  def self.columns_chart
    [['Cantidad','1'], ['Costo por Mano de Obra','2'], ['Costo por Hectárea por Mano de Obra','3'], ['Costo por Hectárea por Insumo','4'], ['Costo por Insumo','5'], ['Costo por Hectárea','6'], ['Costo Total','7']]
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
        {'vAxis' => 'valorizations.cost_insumo', 'vAxisLabel' => 'Costo por Insumo'}
      when 6
        {'vAxis' => 'valorizations.unit_cost_total', 'vAxisLabel' => 'Costo por Hectárea'}
      when 7
        {'vAxis' => 'valorizations.cost_total', 'vAxisLabel' => 'Costo Total'}
      when 8 #>= 8 == Cosechas
        {'vAxis' => 'valorizations.amount', 'vAxisLabel' => 'Hectareas Recorridas'}
      when 9
        {'vAxis' => 'valorizations.metric_tons', 'vAxisLabel' => 'Toneladas Metricas Cosechadas'}
      when 10
        {'vAxis' => 'valorizations.cost_mano', 'vAxisLabel' => 'Costo Cosecha'}
      when 11
        {'vAxis' => 'valorizations.clusters', 'vAxisLabel' => 'Racimos Cosechados'}
      when 12
        {'vAxis' => 'valorizations.bags', 'vAxisLabel' => 'Sacos Recolectados'}
      when 13
        {'vAxis' => 'valorizations.unit_cost_ton', 'vAxisLabel' => 'Costo Por Tonelada'}
      when 14
        {'vAxis' => 'valorizations.clusters_per_amount', 'vAxisLabel' => 'Racimos Por Hectareas Totales'}
      when 15
        {'vAxis' => 'valorizations.plants', 'vAxisLabel' => 'Racimos Por Plantas'}
      when 16
        {'vAxis' => 'valorizations.bags_per_amount', 'vAxisLabel' => 'Sacos Recolectados / Hectareas Recorridas'}
      when 17
        {'vAxis' => 'valorizations.cluster_weight', 'vAxisLabel' => 'Peso De Racimos'}
      else
        {'vAxis' => 'valorizations.amount', 'vAxisLabel' => 'Cantidad'}
    end
  end

  def column_chart(hAxis, vAxis)
    self.variables.pluck("#{hAxis}, #{vAxis}")
  end

  def today_values(category)
    self.variables
      .select("variables.id, variables.name, valorizations.unit_cost_mano, valorizations.amount, valorizations.unit_cost_insumo, valorizations.unit_cost_total, valorizations.cost_total")
      .where(category: category)
      .where("valorizations.assigned_at = ?", Date.today)
  end

  def range_values(category, var_id)
    self.variables
      .where("category": category)
      .where("id": var_id)
      .select("variables.id, variables.name, valorizations.*, valorizations.assigned_at")
      .order("valorizations.assigned_at ASC")
  end

  #This is a waste, just does the same query twice
  def sum_values(category, var_id)
    range_values(category, var_id)
    .pluck("sum(amount), sum(valorizations.unit_cost_mano), sum(cost_mano), sum(valorizations.unit_cost_insumo), sum(cost_insumo), sum(valorizations.unit_cost_total), sum(valorizations.cost_total)")
    .first
  end

  #Returns today's current amount of the given variable as a hash
  #e.g. { name: "VarName", unit_cost_mano: 200, unit_cost_insumo: 300, unit_cost_total: 500, amount: 2, cost_mano: 400, cost_insumo: 600, cost_total: 1000 }
  #Returns nil if variable does not exist
  def getValue(name, date)
    var = Variable.find_by_name(name)
    return nil if var.nil?

    value = self.valorizations.find_by(variable: var, assigned_at: date)
    case var.category.id
    when 1
      hash = { name: var.name, unit_cost_mano: var.unit_cost_mano, unit_cost_insumo: var.unit_cost_insumo, amount: 0, cost_mano: 0, cost_insumo: 0, unit_cost_total: 0, cost_total: 0}
      unless value.nil?
        hash.merge!({ unit_cost_mano: value.unit_cost_mano, unit_cost_insumo: value.unit_cost_insumo, amount: value.amount, cost_mano: value.cost_mano, cost_insumo: value.cost_insumo, unit_cost_total: value.unit_cost_total, cost_total: value.cost_total })
      end
    when 2
      hash = { name: var.name, amount: 0, metric_tons: 0, cost_mano: 0, clusters: 0, bags: 0, unit_cost_ton: 0, clusters_per_amount: 0, plants: 0, bags_per_amount: 0, cluster_weight: 0}
      unless value.nil?
        hash.merge!({ amount: value.amount, metric_tons: value.metric_tons, cost_mano: value.cost_mano, clusters: value.clusters, bags: value.bags, unit_cost_ton: value.unit_cost_ton, clusters_per_amount: value.clusters_per_amount, plants: value.plants, bags_per_amount: value.bags_per_amount, cluster_weight: value.cluster_weight })
      end
    end
    return hash
  end

  #Sets today's current amount of the given variable
  #Returns true on success, otherwise false
  def setValueMantenimiento(name, amount, cost_mano, cost_insumo, date)
    var = Variable.find_by_name(name)
    return false if var.nil?

    value = self.valorizations.find_by(variable: var, assigned_at: date)
    unless value.nil?
      value.update_attributes(amount: amount, cost_mano: cost_mano, cost_insumo: cost_insumo)
    else
      value = self.valorizations.build(variable: var, amount: amount, cost_mano: cost_mano, cost_insumo: cost_insumo, assigned_at: date)
      value.save
    end
  end

  #Sets today's current amount of the given variable
  #Returns true on success, otherwise false
  def setValueCosecha(name, amount, metric_tons, cost_mano, clusters, bags, date)
    var = Variable.find_by_name(name)
    return false if var.nil?

    value = self.valorizations.find_by(variable: var, assigned_at: date)
    unless value.nil?
      puts "Updating Valorization"
      value.update_attributes(amount: amount, metric_tons: metric_tons, cost_mano: cost_mano, clusters: clusters, bags: bags)
    else
      puts "Creating Valorization"
      value = self.valorizations.build(variable: var, amount: amount, metric_tons: metric_tons, cost_mano: cost_mano, clusters: clusters, bags: bags, assigned_at: date)
      value.save
    end
  end

end
