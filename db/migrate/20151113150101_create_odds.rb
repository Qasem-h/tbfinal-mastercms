class CreateOdds < ActiveRecord::Migration
  def change
    create_table :odds do |t|
      t.string :homevalue
      t.string :awayvalue
      t.decimal :homewin
      t.decimal :awaywin
      t.decimal :draw
      t.string :total
      t.decimal :under
      t.decimal :over
      t.references :match, index: true, foreign_key: true
      t.references :odds_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
