module LotsHelper

  def sum_values_date(lot, category, var_id)
    values =
    lot
    .where("category": category)
    .where("id": var_id)
    .select("variables.id, variables.name, valorizations.amount, valorizations.unit_cost_mano, valorizations.cost_mano, valorizations.unit_cost_insumo, valorizations.cost_insumo, valorizations.unit_cost_total, valorizations.cost_total, valorizations.assigned_at")
    .order("valorizations.assigned_at ASC")

    case category.id
    when 1
      total =
      values
      .pluck("sum(amount), sum(valorizations.unit_cost_mano), sum(cost_mano), sum(valorizations.unit_cost_insumo), sum(cost_insumo), sum(valorizations.unit_cost_total), sum(cost_total)")
      .first
      return {amount: total[0], unit_cost_mano: total[1], cost_mano: total[2], unit_cost_insumo: total[3], cost_insumo: total[4], unit_cost_total: total[5], cost_total: total[6]}
    when 2
      total =
      values
      .pluck("sum(amount), sum(metric_tons), sum(valorizations.cost_mano), sum(valorizations.clusters), sum(valorizations.bags), sum(valorizations.unit_cost_ton), sum(valorizations.clusters_per_amount), sum(valorizations.plants), sum(valorizations.bags_per_amount), sum(valorizations.cluster_weight)")
      .first
      return {amount: total[0], metric_tons: total[1], cost_mano: total[2], clusters: total[3], bags: total[4], unit_cost_ton: total[5], clusters_per_amount: total[6], plants: total[7], bags_per_amount: total[8], cluster_weight: total[9]}
    when 3
      total =
      values
      .pluck("sum(valorizations.amount), sum(valorizations.unit_cost_insumo), sum(valorizations.cost_mano), sum(valorizations.cost_total)")
      .first
      return {amount: total[0], unit_cost_insumo: total[1], cost_mano: total[2], cost_total: total[3]}
    end
  end

end
