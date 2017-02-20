class RemoveSectionColumn < ActiveRecord::Migration[5.0]
  def change
  	remove_column :lots, :section
  end
end
