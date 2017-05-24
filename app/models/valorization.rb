class Valorization < ApplicationRecord
  belongs_to :lot
  belongs_to :variable

  #before_create :assign_current_date
  before_create :assign_default_amount
  before_create :copy_unit_cost_mano
  before_create :copy_unit_cost_insumo
  before_create :calculate_unit_cost_mano
  before_create :calculate_unit_cost_insumo
  before_create :calculate_unit_cost_total
  before_create :calculate_cost_total

  #before_update :assign_current_date
  before_update :assign_default_amount
  before_update :calculate_unit_cost_mano
  before_update :calculate_unit_cost_insumo
  before_update :calculate_unit_cost_total
  before_update :calculate_cost_total

  protected
    def assign_current_date
      self.assigned_at = Date.today
    end

    def assign_default_amount
      self.amount = 0 if self.amount.nil?
    end

    def copy_unit_cost_mano
      self.unit_cost_mano = self.variable.unit_cost_mano
    end

    def copy_unit_cost_insumo
      self.unit_cost_insumo = self.variable.unit_cost_insumo
    end

    def calculate_unit_cost_mano
      if(self.variable.category.id == 1)
        self.unit_cost_mano = self.cost_mano / self.amount
      end
    end

    def calculate_unit_cost_insumo
      if(self.variable.category.id == 1)
        self.unit_cost_insumo = self.cost_insumo / self.amount
      end
    end

    def calculate_unit_cost_total
      if(self.variable.category.id == 1)
        self.unit_cost_total = self.unit_cost_mano + self.unit_cost_insumo
      end
    end

    def calculate_cost_total
      if(self.variable.category.id == 1)
        self.cost_total = self.cost_mano + self.cost_insumo
      end
    end
end
