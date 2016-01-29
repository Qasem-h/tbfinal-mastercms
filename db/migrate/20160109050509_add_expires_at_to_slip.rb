class AddExpiresAtToSlip < ActiveRecord::Migration
  def change
    add_column :slips, :expires_at, :datetime
  end
end
