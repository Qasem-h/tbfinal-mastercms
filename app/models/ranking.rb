class Ranking < ActiveRecord::Base
  belongs_to :tipster
  after_update :update_score
  
  def update_score
    tipster.update(score: self.score)
  end
  
end
