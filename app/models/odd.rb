class Odd < ActiveRecord::Base
  belongs_to :match
  belongs_to :odds_type
  scope :ftresult, -> { where(odds_type_id: 1) }
  scope :homeaway, -> { where(odds_type_id: 2) }
  scope :overunder, -> { where(odds_type_id: 3) }
  scope :handicap, -> { where(odds_type_id: 4) }
  scope :htresult, -> { where(odds_type_id: 5) }
  scope :overunder_first, -> { where(odds_type_id: 6) }
  scope :bothteamtoscore, -> { where(odds_type_id: 7) }
  scope :overunder_second, -> { where(odds_type_id: 8) }
  
  
  def self.closest_two
    overunder.where("under > ? AND under < ?", "1.80", "2.30").limit(1).first
  end
  
  def self.half_closest_two
    overunder_first.where("under > ? AND under < ?", "1.80", "2.30").limit(1).first
  end
  
  def self.closest_two_sh
    overunder_second.where("under > ? AND under < ?", "1.80", "2.30").limit(1).first
  end
  
  def self.closest_two_handicap
    handicap.where("homewin > ? AND homewin < ?", "1.60", "2.30").limit(1).first
  end
  
end
