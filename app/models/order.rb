class Order < ActiveRecord::Base
  include Badges
  include PublicActivity::Model
  tracked recipient: :tipster, only: [:update]
  belongs_to :tipster
  has_many :accounts
  has_many :picks, dependent: :destroy, inverse_of: :order
  after_create :create_account, :max_open_bets, :max_open_stakes, :time_active
  after_update :current_streak, if: :handler_false
  after_update :update_winnings, if: :winnings_nil
  after_update :ranking_score
  scope :orderwin, -> { where('status=? OR status=?', 'Win', 'Partial Win') }
  scope :active, -> { where.not(status: nil) }
  scope :pending, -> { where(status: nil)}
  scope :from_date, ->(duration){ where('created_at > ?', Time.zone.today - duration ) }
  
  def add_picks_from_slip(slip)
    slip.picks.each do |item|
      item.slip_id = nil
      picks << item
    end
  end
  
  def ranking_score
    
    rr = [20, tipster.real_win_rate, 0].sort[1]
    growth = [20, tipster.growth * 10, 0].sort[1]
    mt_growth = [20, tipster.mid_term_growth * 20, 0].sort[1]
    recent_growth = [20, tipster.recent_growth * 20, 0].sort[1]
    avg_stake_ratio = [0.1, tipster.average_stake_ratio, 0.4].sort[1]
    asr = (10 - (avg_stake_ratio * 10 )).floor
    recent_stake_ratio = [0.2, tipster.recent_stake_ratio, 0.6].sort[1]
    rasr =  rasr_score = (1 - (recent_stake_ratio * 10)).floor
    betslip_points = tipster.orders.active.count > 100 ? 5 : tipster.orders.active.count * 0.05
    frequency_points = tipster.frequency > 20 ? 5 : tipster.frequency * 0.25
    recency = tipster.recency > 5 ? 5 : tipster.recency * 1
    follower_points = tipster.followers.count > 2000 ? 10 : tipster.followers.count * 0.005
    score = rr + growth + mt_growth + recent_growth + asr + rasr + betslip_points + frequency_points + recency + follower_points

    unless tipster.orders.active.count < 5
      tipster.ranking.update(rr: rr, growth: growth, mt_growth: mt_growth, 
                              recent_growth: recent_growth, asr: asr, rasr: rasr, 
                              betslip_points: betslip_points, frequency_points: frequency_points,
                              recency: recency, follower_points: follower_points, score: score )
    end
    

      
    end
      

  
  def current_streak
    if status == "Win" || status == "Partial Win"
      tipster.losing.reset
      tipster.unbeaten.increment
      tipster.winning.increment
      tipster.winning_streak.increment if tipster.winning.value > tipster.winning_streak.value
      update handler: true
    elsif status == "Lose" || status == "Partial Lose"
      tipster.winning.reset
      tipster.unbeaten.reset
      tipster.losing.increment
      tipster.losing_streak.increment if tipster.losing.value > tipster.losing_streak.value
      update handler: true
    else
      tipster.unbeaten.increment
      update handler: true
    end
  end
  
  
      
  
  def open_stakes
    tipster.orders.map(&:stake).inject(0, :+)
  end
  
  def max_open_bets
    tipster.openbets.increment if tipster.orders.pending.count.to_f > tipster.openbets.to_f
  end
  
  def max_open_stakes
    tipster.maxopenstakes.value = self.open_stakes if self.open_stakes > tipster.maxopenstakes.value
  end
  
  def time_active
    date = Date.today - 1
    tipster.time_active.increment if tipster.orders.where("created_at >= ?", Time.zone.now.beginning_of_day).count < 2
    tipster.time_active.reset unless tipster.orders.where(:created_at => (date.beginning_of_day..date.end_of_day)).exists?
  end
      
  def complete
    update status: 'Win'
  end
  
  def draw
    update status: "Draw"
  end
  
  def lose
    update status: "Lose"
  end
  
  def mix
    update status: "Mix Result"
  end
  
  def winhalf
    update status: "Partial Win"
  end
  
  def losehalf
    update status: "Partial Lose"
  end
  
  private 
  
  def create_account
    balance = self.tipster.accounts.last.balance
    account = self.tipster.accounts
    stake_ratio = self.stake / balance
    account.create(balance: balance - self.stake.to_f, stake: self.stake, stake_ratio: stake_ratio, order_id: id )
  end
  
  def update_winnings
    realodds = picks.map {|a| a.realodds}.inject(:*)
    realwinnings = realodds * stake.to_f
    update winnings: realwinnings
    balance = self.tipster.accounts.last.balance
    account = self.tipster.accounts
    account.create(balance: balance + self.winnings, order_id: id)
  end
  
  def winnings_nil
    winnings == nil
  end
  
  def status_nil
    status == nil
  end
  
  def handler_false
    handler == false
  end
  
  def order_exists?
    tipster.orders.where("created_at >= ?", Time.zone.now.beginning_of_day).exists?
  end
  
end
