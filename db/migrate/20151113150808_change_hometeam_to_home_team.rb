class ChangeHometeamToHomeTeam < ActiveRecord::Migration
  def change
    rename_column :matches, :hometeam, :home_team
    rename_column :matches, :awayteam, :away_team
  end
end
