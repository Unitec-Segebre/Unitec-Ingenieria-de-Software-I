class AddManagerToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :manager, :string
  end
end
