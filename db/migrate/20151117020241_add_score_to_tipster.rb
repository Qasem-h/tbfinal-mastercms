class AddScoreToTipster < ActiveRecord::Migration
  def change
    add_column :tipsters, :score, :decimal, :default => 0
  end
end
