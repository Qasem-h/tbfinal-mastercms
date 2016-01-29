class Pick < ActiveRecord::Base
  belongs_to :match
  belongs_to :order, inverse_of: :picks
  belongs_to :slip, validate: true
  belongs_to :tipster
  after_update :update_odds, if: :realodds_nil
  after_update :order_win, if: :status_complete
  
  
  
  def update_odds
    if pickstatus == "Draw"
      update realodds: 1.00
    elsif pickstatus == "WinHalf"
      update realodds: (odds - 1) / 2 + 1
    elsif pickstatus == "LoseHalf"
      update realodds: 0.50
    elsif pickstatus == "Win"
      update realodds: odds
    elsif pickstatus == "Lose"
      update realodds: 0.00
    end
  end
  
  def order_win
    all_status = order.picks.map do |t|
      t.pickstatus
    end
    case 
    when all_status.uniq[0] == "Win" && all_status.uniq.length == 1
      order.complete
    when all_status.uniq[0] == "Draw" && all_status.uniq.length == 1
      order.draw
    when all_status.include?("Lose")
      order.lose
    when all_status.uniq == ["Win", "WinHalf"] || ["WinHalf", "Win"] || ["Draw", "Win"] || ["Win", "Draw"]
      order.winhalf
    else
      order.losehalf
    end
  end
  
  def win?
    pickstatus == 'Win'
  end
  
  
  private
  
  def status_complete
    all_status = order.picks.map do |t| 
      t.pickstatus.nil?
    end
    !all_status.include? true
  end
  
  def realodds_nil
    realodds == nil
  end

      
      
  def all_picks_status_win?
    order.picks.all?(&:win?)
  end
  
  def picks_lose?
    order.picks.exists?(pickstatus: "Lose")
  end
  
  def picks_winlosehalf?
    order.picks.all.exists?(['pickstatus = ? AND pickstatus = ?', 'WinHalf', 'LoseHalf'])
  end
  
  def picks_winhalf?
    order.picks.exists?(pickstatus: "WinHalf")
  end
  
  def picks_losehalf?
    order.picks.all.exists?(pickstatus: "LoseHalf")
  end
  
  def order_exists?
    !self.order_id.nil?
  end
  
  def pick_status_nil
    self.pickstatus == nil
  end
end
