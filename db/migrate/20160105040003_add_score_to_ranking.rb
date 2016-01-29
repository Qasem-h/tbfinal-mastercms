class AddScoreToRanking < ActiveRecord::Migration
  def change
    add_column :rankings, :score, :decimal, precision: 7, scale: 4
  end
end
