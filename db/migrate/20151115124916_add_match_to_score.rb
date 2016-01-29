class AddMatchToScore < ActiveRecord::Migration
  def change
    add_reference :scores, :match, index: true, foreign_key: true
  end
end
