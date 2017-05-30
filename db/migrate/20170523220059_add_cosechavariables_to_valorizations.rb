class AddCosechavariablesToValorizations < ActiveRecord::Migration[5.0]
  def change
    add_column :valorizations, :metric_tons, :decimal
    add_column :valorizations, :clusters, :decimal
    add_column :valorizations, :bags, :decimal
    add_column :valorizations, :unit_cost_ton, :decimal
    add_column :valorizations, :clusters_per_amount, :decimal
    add_column :valorizations, :plants, :decimal
    add_column :valorizations, :bags_per_amount, :decimal
    add_column :valorizations, :cluster_weight, :decimal
  end
end
