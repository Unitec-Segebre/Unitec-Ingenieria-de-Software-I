class CreateValorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :valorizations do |t|
      t.references :lot, foreign_key: true
      t.references :variable, foreign_key: true
      t.date :assigned_at
      t.decimal :amount
      t.decimal :unit_cost_mano
      t.decimal :unit_cost_insumo
      t.decimal :unit_cost_total
      t.decimal :cost_mano
      t.decimal :cost_insumo
      t.decimal :cost_total

      t.decimal :metric_tons
      t.decimal :clusters
      t.decimal :bags
      t.decimal :unit_cost_ton
      t.decimal :clusters_per_amount
      t.decimal :plants
      t.decimal :bags_per_amount
      t.decimal :cluster_weight

      t.timestamps
    end
  end
end
