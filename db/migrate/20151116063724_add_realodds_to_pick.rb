class AddRealoddsToPick < ActiveRecord::Migration
  def change
    add_column :picks, :realodds, :decimal
  end
end
