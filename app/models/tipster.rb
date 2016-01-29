class Tipster < ActiveRecord::Base
  include Redis::Objects
  include HasActivities
  sorted_set :leaderboard, global: true
  acts_as_followable
  counter :winning
  counter :losing
  counter :unbeaten
  counter :winning_streak
  counter :losing_streak
  counter :maxopenstakes
  counter :openbets
  counter :time_active
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :accounts
  has_many :slips
  has_many :orders
  has_one :ranking
  after_create :open_account, :update_leaderboard
  after_update :update_leaderboard
  has_merit
  
  
  def mid_term_growth
    if orders.active.count > 50
      (accounts.last.balance / orders.last(50).first.accounts.second.balance) - 1
    else
      0
    end
  end
  
  def average_stake_ratio
    accounts.ratio.average(:stake_ratio)
  end
  
  def recent_stake_ratio
    accounts.ratio.order("created_at DESC").limit(8).average(:stake_ratio)
  end
  
  def recent_growth
    if orders.active.count > 50
      (accounts.last.balance / orders.last(8).first.accounts.second.balance) - 1
    else
      0
    end
  end
  
  def frequency
    orders.from_date(30.days).count
  end
  
  def recency
    orders.from_date(10.days).count
  end
  
  
      
  
  def total_winnings
    orders.active.inject(0) {|sum, p| sum + p.winnings}
  end
  
  def total_max_possible_winnings
    orders.active.inject(0) {|sum, p| sum + p.possible_winnings}
  end
  
  def real_win_rate
    (self.total_winnings / self.total_max_possible_winnings).to_f * 20
  end
      
  def unviewed_notifications
    notifications.where(viewed: false)
  end
  
  def latest_notifications
    unviewed = unviewed_notifications.limit(10)
    
    if unviewed.count < 10
      remaining_count = 10 - unviewed.count
      unviewed += notifications.where(viewed: true).limit(remaining_count)
    end

    unviewed
  end
  
  def win_rate
    if orders.active.count == 0
      "--"
    else
      orders.orderwin.count.to_f / orders.active.count.to_f
    end
  end
  
  def growth
      (accounts.last.balance / accounts.first.balance) - 1
  end
  
  def total_bets
    orders.count
  end
  
  def age
    Date.today - self.created_at.to_date
  end
  
  def avg_stake_ratio
    self.accounts.sum(:stake_ratio) / self.orders.count
  end
  
  def avg_bets_placed
    if self.total_bets > 0
    ((self.total_bets.to_f / (self.age + 1).to_f) * 7).round(2)
    else
      0
    end
  end
  
  def open_bets
    self.orders.pending.count
  end
  
  def total_grouped_by_day
    stakes = accounts.group("DATE_TRUNC('day', created_at)").sum(:stake)
    balances = stakes.map do |k, v|
      {period: k, stakes: v, balance: 50000}
    end
    balances
  end
  
  def form
    orders.active.pluck(:status).last(8)
  end
  
  private
  
  def open_account
    self.accounts.create(balance: 50000)
    Ranking.create(score: 0, tipster_id: id)
  end
  
  def update_leaderboard
    self.class.leaderboard[id] = score
  end
  
end
