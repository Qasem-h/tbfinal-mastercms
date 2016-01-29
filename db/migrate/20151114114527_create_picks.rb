class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.string :matchid
      t.decimal :odds, precision: 12, scale: 3
      t.string :status
      t.string :team
      t.string :pickstatus
      t.string :bettype
      t.string :bet
      t.references :match, index: true, foreign_key: true
      t.references :tipster, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
