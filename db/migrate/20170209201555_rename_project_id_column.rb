class RenameProjectIdColumn < ActiveRecord::Migration[5.0]
  def change
  	rename_column :lots, :proyect_id, :project_id
  end
end
