class Valorization < ApplicationRecord
  belongs_to :lot
  belongs_to :variable

  before_create :assign_default_amount
  before_create :copy_unit_cost_mano
  before_create :copy_unit_cost_insumo
  before_create :calculate_unit_cost_mano
  before_create :calculate_unit_cost_insumo
  before_create :calculate_unit_cost_total
  before_create :calculate_cost_total
  before_create :calculate_unit_cost_ton
  before_create :calculate_clusters_per_amount
  before_create :calculate_plants
  before_create :calculate_bags_per_amount
  before_create :calculate_cluster_weight


  before_update :assign_default_amount
  before_update :calculate_unit_cost_mano
  before_update :calculate_unit_cost_insumo
  before_update :calculate_unit_cost_total
  before_update :calculate_cost_total
  before_update :calculate_unit_cost_ton
  before_update :calculate_clusters_per_amount
  before_update :calculate_plants
  before_update :calculate_bags_per_amount
  before_update :calculate_cluster_weight

  protected
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

    def calculate_unit_cost_ton
      if(self.variable.category.id == 2)
        self.unit_cost_ton = self.cost_mano/self.metric_tons
      end
    end

    def calculate_clusters_per_amount
      if(self.variable.category.id == 2)
        self.clusters_per_amount = self.clusters/self.lot.hectares
      end
    end

    def calculate_plants
      if(self.variable.category.id == 2)
        self.plants = self.clusters/143
      end
    end

    def calculate_bags_per_amount
      if(self.variable.category.id == 2)
        self.bags_per_amount = self.bags/self.amount
      end
    end

    def calculate_cluster_weight
      if(self.variable.category.id == 2)
        self.cluster_weight = (self.metric_tons*2200)/self.clusters
      end
    end
end
