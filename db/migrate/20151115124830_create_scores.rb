class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :status
      t.integer :ht_home_goal
      t.integer :ht_away_goal
      t.integer :ft_home_goal
      t.integer :ft_away_goal
      t.integer :et_home_goal
      t.integer :et_away_goal
      t.integer :penalty_home
      t.integer :penalty_away
      t.string :first_goal
      t.string :last_goal

      t.timestamps null: false
    end
  end
end
