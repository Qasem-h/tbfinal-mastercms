class CreateSlips < ActiveRecord::Migration
  def change
    create_table :slips do |t|
      t.integer :stake
      t.decimal :winnings,             precision: 16, scale: 3
      t.decimal :possible_winnings,             precision: 16, scale: 3
      t.string :status
      t.references :tipster, index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
