class AddLeagueToMatch < ActiveRecord::Migration
  def change
    add_reference :matches, :league, index: true, foreign_key: true
  end
end
