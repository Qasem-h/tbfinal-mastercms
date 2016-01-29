class AddGrowthToRanking < ActiveRecord::Migration
  def change
    add_column :rankings, :growth, :decimal, precision: 7, scale: 4
  end
end
