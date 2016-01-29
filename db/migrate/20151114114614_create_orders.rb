class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :stake,             precision: 16, scale: 3
      t.decimal :winnings,             precision: 16, scale: 3
      t.string :status
      t.decimal :possible_winnings,             precision: 16, scale: 3
      t.references :tipster, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
