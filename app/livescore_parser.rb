Parse Livescore into DB

Model

Score

belongs_to :match

status:string
ht_home_goal:integer
ht_away_goal:integer
ft_home_goal:integer
ft_away_goal:integer
et_home_goal:integer
et_away_goal:integer
penalty_home:integer
penalty_away:integer
first_goal:string
last_goal:string

Only write to DB if status are  -> FT / AET / Postp. / Pen.

when status == FT

update status to FT
update ht_home_goal, ht_away_goal, ft_home_goal, ft_away_goal, first_goal, last_goal

when status == AET

update status to AET
update all except penalty_home, penalty_away

when status == Pen

update all

when status == Postp.

update status to Postpone

http://www.tipgin.net/datav2/accounts/monsoonm/soccer/livescore/livescore.xml
http://www.tipgin.net/datav2/accounts/monsoonm/soccer/livescore/d-1.xml
http://www.tipgin.net/datav2/accounts/monsoonm/soccer/livescore/d-2.xml
http://www.tipgin.net/datav2/accounts/monsoonm/soccer/livescore/d-3.xml
http://www.tipgin.net/datav2/accounts/monsoonm/soccer/livescore/d-4.xml
http://www.tipgin.net/datav2/accounts/monsoonm/soccer/livescore/d-5.xml
