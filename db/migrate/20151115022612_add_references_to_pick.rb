class AddReferencesToPick < ActiveRecord::Migration
  def change
    add_reference :picks, :order, index: true, foreign_key: true
    add_reference :picks, :slip, index: true, foreign_key: true
  end
end
