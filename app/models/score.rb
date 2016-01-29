class Score < ActiveRecord::Base
  belongs_to :match
  has_many :picks, through: :match
  after_commit :add_pick_status, if: :picks_nil?
  
  
  def add_picks_statuss
    case status
    when "FT"
      if self.ft_home_goal == self.ft_away_goal
        self.match.picks.map do |t|
          t.update(status: "Draw")
        end
      elsif self.ft_home_goal > self.ft_away_goal
        self.match.picks.map do |t|
          t.update(status: "HomeWin")
        end
      else
        self.match.picks.map do |t|
          t.update(status: "AwayWin")
        end
      end
    when "Postp."
      self.match.picks.map do |t|
        t.update(status: "Postpone")
      end
    end
  end
  
  def add_pick_status222
    self.picks.each do |t|
      case t.bettype
      when "1x2 1st Half"
        home_score = t.score.ht_home_goal
        away_score = t.score.ht_away_goal
        if home_score == away_score && t.bet == "Draw"
          t.update(pickstatus: "Win")
        elsif home_score > away_score && t.bet == "1"
          t.update(pickstatus: "Win")
        elsif home_score < away_score && t.bet == "2"
          t.update(pickstatus: "Win")
        else
          t.update(pickstatus: "Lose")
        end
      when "HomeAway"
        home_score = t.score.ft_home_goal
        away_score = t.score.ft_away_goal
        if home_score > away_score && t.bet == "1"
          t.update(pickstatus: "Win")
        elsif home_score < away_score && t.bet == "2"
          t.update(pickstatus: "Win")
        elsif home_score == away_score
          t.update(pickstatus: "Draw")
        else
          t.update(pickstatus: "Lose")
        end
      when "Goal Line"
        total_goal = ft_home_goal + ft_away_goal
        case t.bet
        when "Over"
          if total_goal > t.total.to_f && total_goal - t.total.to_f > 0.25
            t.update(pickstatus: "Win")
          elsif total_goal > t.total.to_f && total_goal - t.total.to_f == 0.25
            t.update(pickstatus: "WinHalf")
          elsif total_goal < t.total.to_f && total_goal - t.total.to_f == 0.25
            t.update(pickstatus: "LoseHalf")
          else
            t.update(pickstatus: "Lose")
          end
        end
      end
    end
  end
  
  def add_pick_status
    
  if status == "Postp."
    self.match.picks.map do |t|
      t.update(status: "Postpone")
    end
  else
    total_goal = ft_home_goal + ft_away_goal
    fh_total_goal = ht_home_goal + ht_away_goal
    sh_total_goal = total_goal - fh_total_goal
    self.picks.each do |t|
    case t.bettype
    when "Goal Line"
      case t.bet
      when "Over"
        if total_goal > t.total.to_f && total_goal - t.total.to_f > 0.25
          t.update(pickstatus: "Win")
        elsif total_goal > t.total.to_f && total_goal - t.total.to_f == 0.25
          t.update(pickstatus: "WinHalf")
        elsif total_goal < t.total.to_f && t.total.to_f - total_goal == 0.25
          t.update(pickstatus: "LoseHalf")
        else
          t.update(pickstatus: "Lose")
        end
      when "Under"
        if total_goal < t.total.to_f && total_goal - t.total.to_f < 0.25
          t.update(pickstatus: "Win")
        elsif total_goal < t.total.to_f &&  t.total.to_f - total_goal == 0.25
          t.update(pickstatus: "WinHalf")
        elsif total_goal > t.total.to_f && total_goal - t.total.to_f == 0.25
          t.update(pickstatus: "LoseHalf")
        else
          t.update(pickstatus: "Lose")
        end
      end
    when "Goal Line 1st Half"
      case t.bet
      when "Over"
        if fh_total_goal > t.total.to_f && fh_total_goal - t.total.to_f > 0.25
          t.update(pickstatus: "Win")
        elsif fh_total_goal > t.total.to_f && fh_total_goal - t.total.to_f == 0.25
          t.update(pickstatus: "WinHalf")
        elsif fh_total_goal < t.total.to_f && t.total.to_f - fh_total_goal == 0.25
          t.update(pickstatus: "LoseHalf")
        else
          t.update(pickstatus: "Lose")
        end
      when "Under"
        if fh_total_goal < t.total.to_f && fh_total_goal - t.total.to_f < 0.25
          t.update(pickstatus: "Win")
        elsif fh_total_goal < t.total.to_f &&  t.total.to_f - fh_total_goal == 0.25
          t.update(pickstatus: "WinHalf")
        elsif fh_total_goal > t.total.to_f && fh_total_goal - t.total.to_f == 0.25
          t.update(pickstatus: "LoseHalf")
        else
          t.update(pickstatus: "Lose")
        end
      end
    when "Goal Line Second Half"
      case t.bet
      when "Over"
        if sh_total_goal > t.total.to_f && sh_total_goal - t.total.to_f > 0.25
          t.update(pickstatus: "Win")
        elsif sh_total_goal > t.total.to_f && sh_total_goal - t.total.to_f == 0.25
          t.update(pickstatus: "WinHalf")
        elsif sh_total_goal < t.total.to_f && t.total.to_f - sh_total_goal == 0.25
          t.update(pickstatus: "LoseHalf")
        else
          t.update(pickstatus: "Lose")
        end
      when "Under"
        if sh_total_goal < t.total.to_f && sh_total_goal - t.total.to_f < 0.25
          t.update(pickstatus: "Win")
        elsif sh_total_goal < t.total.to_f &&  t.total.to_f - sh_total_goal == 0.25
          t.update(pickstatus: "WinHalf")
        elsif sh_total_goal > t.total.to_f && sh_total_goal - t.total.to_f == 0.25
          t.update(pickstatus: "LoseHalf")
        else
          t.update(pickstatus: "Lose")
        end
      end
    when "1x2 1st Half"
      if ht_home_goal == ht_away_goal && t.bet == "Draw"
        t.update(pickstatus: "Win")
      elsif ht_home_goal > ht_away_goal && t.bet == "1"
        t.update(pickstatus: "Win")
      elsif ht_home_goal < ht_away_goal && t.bet == "2"
        t.update(pickstatus: "Win")
      else
        t.update(pickstatus: "Lose")
      end
    when "1x2"
      if ft_home_goal == ft_away_goal && t.bet == "Draw"
        t.update(pickstatus: "Win")
      elsif ft_home_goal > ft_away_goal && t.bet == "1"
        t.update(pickstatus: "Win")
      elsif ft_home_goal < ft_away_goal && t.bet == "2"
        t.update(pickstatus: "Win")
      else
        t.update(pickstatus: "Lose")
      end
    when "HomeAway"
      if ft_home_goal > ft_away_goal && t.bet == "1"
        t.update(pickstatus: "Win")
      elsif ft_home_goal < ft_away_goal && t.bet == "2"
        t.update(pickstatus: "Win")
      elsif ft_home_goal == ft_away_goal
        t.update(pickstatus: "Draw")
      else
        t.update(pickstatus: "Lose")
      end
    when "Handicap"
      case t.bet
      when "1"
        if t.total == "0"
          if ft_home_goal - ft_away_goal == 0
            t.update(pickstatus: "Draw")
          elsif ft_home_goal - ft_away_goal > 0 
            t.update(pickstatus: "Win")
          else
            t.update(pickstatus: "Lose")
          end
        else
          if ft_home_goal.send(t.total[0].to_sym, t.total[1..-1].to_f) - ft_away_goal == 0
            t.update(pickstatus: "Draw")
          elsif ft_home_goal.send(t.total[0].to_sym, t.total[1..-1].to_f) - ft_away_goal == 0.25
            t.update(pickstatus: "WinHalf")
          elsif ft_home_goal.send(t.total[0].to_sym, t.total[1..-1].to_f) - ft_away_goal == -0.25
            t.update(pickstatus: "LoseHalf")
          elsif ft_home_goal.send(t.total[0].to_sym, t.total[1..-1].to_f) - ft_away_goal > 0.25
            t.update(pickstatus: "Win")
          else
            t.update(pickstatus: "Lose")
          end
        end
      when "2"
        if t.total == "0"
          if ft_away_goal - ft_home_goal == 0
            t.update(pickstatus: "Draw")
          elsif ft_away_goal - ft_home_goal > 0 
            t.update(pickstatus: "Win")
          else
            t.update(pickstatus: "Lose")
          end
        else
          if ft_away_goal.send(t.total[0].to_sym, t.total[1..-1].to_f) - ft_home_goal == 0
            t.update(pickstatus: "Draw")
          elsif ft_away_goal.send(t.total[0].to_sym, t.total[1..-1].to_f) - ft_home_goal == 0.25
            t.update(pickstatus: "WinHalf")
          elsif ft_away_goal.send(t.total[0].to_sym, t.total[1..-1].to_f) - ft_home_goal == -0.25
            t.update(pickstatus: "LoseHalf")
          elsif ft_away_goal.send(t.total[0].to_sym, t.total[1..-1].to_f) - ft_home_goal > 0.25
            t.update(pickstatus: "Win")
          else
            t.update(pickstatus: "Lose")
          end
        end
      end
    end
    end
    end
  end
  
  private
  
  def picks_nil?
    !picks.first.nil?
  end
          
          
end
