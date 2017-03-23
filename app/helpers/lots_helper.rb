module LotsHelper

  def range_values_date(lot, category, var_id)
    lot
      .where("category": category)
      .where("id": var_id)
      .select("variables.id, variables.name, valorizations.amount, valorizations.unit_cost, valorizations.subtotal, valorizations.assigned_at")
      .order("valorizations.assigned_at ASC")
  end

  def sum_values_date(lot, category, var_id)
    range_values_date(lot, category, var_id)
    .pluck("sum(amount), sum(valorizations.unit_cost), sum(subtotal)")
    .first
  end

end
