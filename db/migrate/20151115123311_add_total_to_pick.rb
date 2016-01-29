class AddTotalToPick < ActiveRecord::Migration
  def change
    add_column :picks, :total, :string
  end
end
