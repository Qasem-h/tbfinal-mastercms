class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :matchid
      t.string :alternate_id
      t.string :hometeam
      t.string :awayteam

      t.timestamps null: false
    end
  end
end
