Country
has_many :leagues


League
has_many :matches
belongs_to :country

Match
has_many :odds
belongs_to :leauge

Odds
belongs_to :match
belongs_to :odds_type

OddsType
has_many :odds


Match
static_id:string
alternate_id:string
date:datetime
home_team:string
away_team:string


Odds
homevalue:string
awayvalue:string
homewin:decimal
awaywin:decimal
draw:decimal
total:string
under:decimal
over:decimal


OddsType
1x2
Home/Away
Over/Under
Handicap
1x2 1st Half
Over/Under 1st Half
Both Teams to Score
Over/Under 2nd Half
