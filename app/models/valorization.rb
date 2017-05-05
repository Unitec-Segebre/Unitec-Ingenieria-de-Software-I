class Valorization < ApplicationRecord
  belongs_to :lot
  belongs_to :variable

  before_create :assign_current_date
  before_create :assign_default_amount
  before_create :copy_unit_cost_mano
  before_create :calculate_unit_cost_mano

  before_update :assign_current_date
  before_update :assign_default_amount
  before_update :calculate_unit_cost_mano

  protected
    def assign_current_date
      self.assigned_at = Date.today
    end

    def assign_default_amount
      self.amount = 0 if self.amount.nil?
    end

    def copy_unit_cost_mano
      self.unit_cost = self.variable.unit_cost
    end

    def calculate_unit_cost
      self.unit_cost = self.subtotal / self.amount
    end
end
