class RenameUnidadColumn < ActiveRecord::Migration[5.0]
  def change
  	rename_column :variables, :unidad, :unit
  end
end
