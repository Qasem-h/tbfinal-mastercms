class AddUsernameToTipster < ActiveRecord::Migration
  def change
    add_column :tipsters, :username, :string
  end
end
