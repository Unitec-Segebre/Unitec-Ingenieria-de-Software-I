class AddCosechavariablesToValorizations < ActiveRecord::Migration[5.0]
  def change
    add_column :valorizations, :metric_tons, :string
    add_column :valorizations, :clusters, :string
    add_column :valorizations, :bags, :string
    add_column :valorizations, :unit_cost_ton, :string
    add_column :valorizations, :clusters_per_amount, :string
    add_column :valorizations, :plants, :string
    add_column :valorizations, :bags_per_amount, :string
    add_column :valorizations, :cluster_weight, :string
  end
end
