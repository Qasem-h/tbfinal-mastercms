class AddFieldsToTipsters < ActiveRecord::Migration
  def change
    add_column :tipsters, :sash_id, :integer
    add_column :tipsters, :level,   :integer, :default => 0
  end
end
