class AddDetailsToRanking < ActiveRecord::Migration
  def change
    add_column :rankings, :mt_growth, :decimal, precision: 6, scale: 4
    add_column :rankings, :recent_growth, :decimal, precision: 6, scale: 4
    add_column :rankings, :asr, :decimal, precision: 6, scale: 4
    add_column :rankings, :rasr, :decimal, precision: 6, scale: 4
    add_column :rankings, :betslip_points, :decimal, precision: 6, scale: 4
    add_column :rankings, :frequency_points, :decimal, precision: 6, scale: 4
    add_column :rankings, :recency, :decimal, precision: 6, scale: 4
    add_column :rankings, :follower_points, :decimal, precision: 6, scale: 4
  end
end
