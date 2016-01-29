class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.decimal :balance, precision: 16, scale: 2
      t.integer :stake, precision: 6,  scale: 3
      t.decimal :stake_ratio
      t.references :tipster, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
