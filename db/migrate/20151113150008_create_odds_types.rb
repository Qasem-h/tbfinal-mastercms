class CreateOddsTypes < ActiveRecord::Migration
  def change
    create_table :odds_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
