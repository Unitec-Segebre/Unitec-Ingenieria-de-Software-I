class CreateVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :variables do |t|
      t.string :name
      t.string :unidad
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
