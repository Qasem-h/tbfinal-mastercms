class Account < ActiveRecord::Base
  belongs_to :tipster
  belongs_to :order
  scope :ratio, -> { where.not(stake_ratio: nil)} 
  include BadgesRr


  
  
end
