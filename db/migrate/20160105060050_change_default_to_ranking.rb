class ChangeDefaultToRanking < ActiveRecord::Migration

  def up
    change_column_default :rankings, :growth, 0
    change_column_default :rankings, :rr, 0
    change_column_default :rankings, :score, 0
  end

  def down
    change_column_default :rankings, :growth, nil
    change_column_default :rankings, :rr, nil
    change_column_default :rankings, :score, nil
  end
  
  
end
