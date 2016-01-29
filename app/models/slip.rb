class Slip < ActiveRecord::Base
  belongs_to :tipster
  belongs_to :account
  has_many :picks, dependent: :destroy
  
  def possible_winningss
   picks.map {|a| a.odds}.inject(:*)
  end
  
  def add_pick(match_id, odds, team, tipster, matchid, bettype, bet, total)
    current_pick = picks.find_by_match_id(match_id)
    if current_pick
      current_pick
    else
      current_pick = picks.build(match_id: match_id, odds: odds, team: team, tipster_id: tipster.id, matchid: matchid, bettype: bettype, bet: bet, total: total)
    end
    current_pick
  end
  
  def expired?
    if self.expires_at
       return (self.expires_at < Time.now)
    else
       false
    end
  end
  
end
