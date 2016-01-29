class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.decimal :rr, precision: 7, scale: 4
      t.references :tipster, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
