class Match < ActiveRecord::Base
  has_many :odds, dependent: :destroy
  has_many :picks
  has_one :score, dependent: :destroy
  belongs_to :league
  scope :today, lambda{ where("date BETWEEN ? AND ?", Time.now, Time.now + 24.hours ) }
  scope :havent_start, lambda{ where("date > ?", Time.now + 20.minutes)}
  
  
  def name
    "#{home_team} vs #{away_team}"
  end
  
end
