class AddStaticIdToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :static_id, :string
  end
end
