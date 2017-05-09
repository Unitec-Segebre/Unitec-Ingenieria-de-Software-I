class CreateValorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :valorizations do |t|
      t.references :lot, foreign_key: true
      t.references :variable, foreign_key: true
      t.date :assigned_at
      t.decimal :amount
      t.decimal :unit_cost_mano
      t.decimal :unit_cost_insumo
      t.decimal :cost_mano
      t.decimal :cost_insumo

      t.timestamps
    end
  end
end
