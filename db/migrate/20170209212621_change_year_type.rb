class ChangeYearType < ActiveRecord::Migration[5.0]
  def change
  	change_column :lots, :sown_at, :integer
  end
end
