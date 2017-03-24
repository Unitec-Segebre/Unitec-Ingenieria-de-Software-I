class CreateValorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :valorizations do |t|
      t.references :lot, foreign_key: true
      t.references :variable, foreign_key: true
      t.date :assigned_at
      t.decimal :amount
      t.decimal :unit_cost
      t.decimal :subtotal

      t.timestamps
    end
  end
end
