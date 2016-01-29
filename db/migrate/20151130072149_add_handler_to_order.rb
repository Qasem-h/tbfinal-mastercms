class AddHandlerToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :handler, :boolean, :default => false
  end
end
