require 'json'
class Abc
  
  def abc
     file = File.read('public/odds/odds.json')
     abc = JSON.parse(file)
  end
    
    def bbc
      abc.each do |a|
        league = League.where(:name => a["league"])
          .first_or_create
          
         match = Match.find_or_create_by(home_team: a["hometeam"], away_team: a["awayteam"], league_id: league.id, date: a["date"])
         a["odds"].each do |b|
         Odd.find_or_create_by(match_id: match.id, homewin: b["homewin"], awaywin: b["awaywin"], draw: b["draw"], homevalue: b["homevalue"], awayvalue: b["awayvalue"], draw: b["draw"], total: b["total"], over: b["over"], under: b["under"], odds_type_id: b["odds_type_id"])
         end
       end
     end
    
  end