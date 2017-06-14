class CreateLots < ActiveRecord::Migration[5.0]
  def change
    create_table :lots do |t|
      t.string :name
      t.integer :sown_at
      t.string :material
      t.integer :section
      t.decimal :hectares
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
