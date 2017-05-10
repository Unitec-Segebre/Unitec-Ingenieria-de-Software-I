module LotsHelper

  def range_values_date(lot, category, var_id)
    lot
      .where("category": category)
      .where("id": var_id)
      .select("variables.id, variables.name, valorizations.amount, valorizations.unit_cost_mano, valorizations.cost_mano, valorizations.unit_cost_insumo, valorizations.cost_insumo, valorizations.unit_cost_total, valorizations.cost_total, valorizations.assigned_at")
      .order("valorizations.assigned_at ASC")
  end

  def sum_values_date(lot, category, var_id)
    range_values_date(lot, category, var_id)
    .pluck("sum(amount), sum(valorizations.unit_cost_mano), sum(cost_mano), sum(valorizations.unit_cost_insumo), sum(cost_insumo), sum(valorizations.unit_cost_total)")
    .first
  end

end
