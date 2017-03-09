class Lot < ApplicationRecord
  has_many :valorizations
  has_many :variables, through: :valorizations
  belongs_to :project

  def today_values(category)
    self.variables
      .select("variables.id, variables.name, valorizations.unit_cost, valorizations.amount")
      .where(category: category)
      .where("valorizations.assigned_at = ?", Date.today)
  end

  #TODO: Dynamic
  def range_values(category)
    variables
      .where(category: category)
      .select("variables.id, variables.name, valorizations.amount, valorizations.unit_cost, valorizations.subtotal, valorizations.assigned_at")
      .where("valorizations.assigned_at": Date.today.in_time_zone('Central America')-7.days...Date.tomorrow.in_time_zone('Central America'))
      .order("valorizations.assigned_at ASC")
  end

   def sum_values(category)
    range_values(category)
    .pluck("sum(amount), sum(valorizations.unit_cost), sum(subtotal)")
    .first
  end

  #Returns today's current amount of the given variable as a hash
  #e.g. { name: "VarName", unit_cost: 200, amount: 2, subtotal: 400 }
  #Returns nil if variable does not exist
  def getVariable(name)
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
  def setVariable(name, amount)
    var = Variable.find_by_name(name)
    return false if var.nil?

    value = self.valorizations.find_by(variable: var, assigned_at: Date.today)
    unless value.nil?
      value.update_attributes(amount: amount)
    else
      value = self.valorizations.build(variable: var, amount: amount)
      value.save
    end
  end
end
