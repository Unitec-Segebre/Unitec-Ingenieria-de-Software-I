class CreateVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :variables do |t|
      t.string :measurement_unit
      t.decimal :unit_cost
      t.string :name
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
