require 'json'
class ScoreMparser
  def score
     file = File.read('public/odds/score.json')
     score = JSON.parse(file)
  end
    
    def parse_score
      score.each do |a|
         match = Match.find_by(static_id: a["static_id"])
         Score.find_or_create_by(match_id: match.id, status: a["status"], ht_home_goal: a["ht_home_goal"], ht_away_goal: a["ht_away_goal"], ft_home_goal: a["ft_home_goal"], ft_away_goal: a["ft_away_goal"], first_goal: a["first_goal"], last_goal: a["last_goal"])
       end
     end
    
  end