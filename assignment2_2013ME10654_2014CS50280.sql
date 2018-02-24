--1--

select player_name from player where batting_hand='Left-hand bat' and country_name='England' order by player_name asc;

--2--
age wrong,order by string
extract year from age
select player_name,player_age from (select player_name,DATE_PART('year', age('2018-12-02',dob)) as player_age from player where bowling_skill='Legbreak googly') as age_table where player_age>=28 order by player_age desc,player_name asc;

SELECT player_name, (DATE_PART('year','2018-12-02'::date) - DATE_PART('year', dob)) AS player_age FROM player WHERE bowling_skill = 'Legbreak googly' AND (DATE_PART('year','2018-12-02'::date) - DATE_PART('year', dob)) >= 28 ORDER BY player_age DESC, player_name ASC;
--3--

select match_id,toss_winner from match where toss_decision='bat' order by match_id asc;

--4--

select over_id,runs_scored from (select over_id,innings_no,sum(runs) as runs_scored from ((select over_id,innings_no,runs_scored as runs from batsman_scored where match_id=335987) union all (select over_id,innings_no,extra_runs as runs from extra_runs where match_id=335987)) as total_runs group by over_id,innings_no) as table1 where runs_scored<=7 order by runs_scored desc,over_id asc;

--5--

select player_name from (select distinct striker from (select match_id,over_id,ball_id,innings_no from wicket_taken where kind_out='bowled') as foo natural join ball_by_ball) as bar,player where striker=player_id order by player_name asc;

--6--

select match_id,team_1,name as team_2,winning_team_name,win_margin from (select match_id,name as team_1,team_2,winning_team_name,win_margin from (select match_id,team_1,team_2,name as winning_team_name,win_margin from match,team where win_margin>=60 and team.team_id=match.match_winner) as foo,team where team_1=team_id) as bar,team where team_2=team_id order by win_margin asc,match_id asc;

--7--
age wrong
select player_name from player where batting_hand='Left-hand bat' and DATE_PART('year', age('2018-12-02',dob))<30 order by player_name asc;

--8--

select match_id,sum(runs) as total_runs from ((select match_id,runs_scored as runs from batsman_scored) union all (select match_id,extra_runs as runs from extra_runs)) as total_r group by match_id order by match_id asc;

--9--
order by player_name or innings_no??

with customtt as (select mid,oid,in_no,total_runs,bowler from (select match_id as mid,over_id as oid,innings_no as in_no,sum(runs) as total_runs from ((select match_id,over_id,innings_no,runs_scored as runs from batsman_scored) union all (select match_id,over_id,innings_no,extra_runs as runs from extra_runs)) as total1 group by match_id,over_id,innings_no) as total_r,(select distinct match_id,over_id,innings_no,bowler from ball_by_ball) as bowlertable where mid=match_id and oid=over_id and in_no=innings_no) select mid as match_id,total_runs as maximum_runs,player_name from (select mid,oid,in_no,total_runs,bowler from customtt where (mid,total_runs) in (select mid,max(total_runs) from customtt group by mid)) as ttt,player where player_id=bowler order by mid,oid,player_name asc;

--10--

select player_name,number from (select player_name,coalesce(number,0) as number from (select player_id,player_name,number from (select player_out,count(player_out) as number from wicket_taken where kind_out='run out' group by player_out) as total_out,player where player_id=player_out) as foo natural right outer join player) as bar order by number desc,player_name asc;

--11--
zeros does not exists???
select kind_out as out_type,count(kind_out) as number from wicket_taken group by kind_out order by number desc,out_type asc;

--12--

select name,count(name) as number from (select team_id from (select man_of_the_match,match_id from match) as foo,player_match where man_of_the_match=player_id and foo.match_id=player_match.match_id) as bar,team where bar.team_id=team.team_id group by team.team_id order by name asc;

--13--

with venue_wides as (select venue,count(venue) as number from match,extra_runs where extra_type='wides' and extra_runs.match_id=match.match_id group by venue order by venue) select venue from venue_wides where number in (select max(number) from venue_wides) limit 1;

--14--

SELECT venue FROM (SELECT venue, count(*) as count FROM match WHERE (toss_decision='field' AND toss_winner = match_winner) OR (toss_decision = 'bat' AND toss_winner != match_winner) GROUP BY venue) AS foo order by count desc,venue;

--15--

with finalt as (select bowler,round(((total_runs*1.0)/wickets),3) as bowling_average from (select bowler,sum(runs) as total_runs from (((select match_id,over_id,ball_id,innings_no,runs_scored as runs from batsman_scored) union all (select match_id,over_id,ball_id,innings_no,extra_runs as runs from extra_runs)) as foo natural join ball_by_ball) as bar group by bowler) as foo1 natural join (select bowler,count(bowler) as wickets from wicket_taken natural join ball_by_ball group by bowler) as bar1) select player_name from finalt,player where bowler=player.player_id and bowling_average in (select min(bowling_average) from finalt) order by player_name asc;

--16--

select player_name,name from player,team,(select player_id,team_id from match,(select player_id,team_id,match_id from player_match where role='CaptainKeeper') as captain_player where match.match_id=captain_player.match_id and match.match_winner = captain_player.team_id) as tmpp where tmpp.player_id=player.player_id and tmpp.team_id=team.team_id order by player_name,name;

--17--

select player_name,runs_scored from player,(select striker,sum(runs) as runs_scored from  ball_by_ball,((select match_id,over_id,ball_id,innings_no,runs_scored as runs from batsman_scored where runs_scored>0) ) as runs_score where runs_score.match_id = ball_by_ball.match_id and runs_score.over_id = ball_by_ball.over_id and runs_score.ball_id = ball_by_ball.ball_id and runs_score.innings_no = ball_by_ball.innings_no group by striker) as total_runs where striker=player_id and striker in (select striker from (select striker,max(runs_scored) as max_runs from (select runs_score.match_id,striker,sum(runs) as runs_scored from  ball_by_ball,((select match_id,over_id,ball_id,innings_no,runs_scored as runs from batsman_scored where runs_scored>0) ) as runs_score where runs_score.match_id = ball_by_ball.match_id and runs_score.over_id = ball_by_ball.over_id and runs_score.ball_id = ball_by_ball.ball_id and runs_score.innings_no = ball_by_ball.innings_no group by runs_score.match_id,striker) as total_runs group by striker) as fifty where max_runs>=50) order by runs_scored desc,player_name;

--18--

select player_name from player,match,(select player_match.match_id,team_id,striker from player_match,(select runs_score.match_id,striker,sum(runs) as runs_scored from  ball_by_ball,(select match_id,over_id,ball_id,innings_no,runs_scored as runs from batsman_scored where runs_scored>0) as runs_score where runs_score.match_id = ball_by_ball.match_id and runs_score.over_id = ball_by_ball.over_id and runs_score.ball_id = ball_by_ball.ball_id and runs_score.innings_no = ball_by_ball.innings_no group by runs_score.match_id,striker) as total_runs where runs_scored>=100 and total_runs.match_id=player_match.match_id and player_id=striker) as century where century.match_id=match.match_id and team_id!=match_winner and player_id=striker order by player_name asc;

--19--

select match_id,venue from match where (team_1 in (select team_id from team where name='Kolkata Knight Riders') or team_2 in (select team_id from team where name='Kolkata Knight Riders')) and match_winner!=(select team_id from team where name='Kolkata Knight Riders') order by match_id asc;

--20--

select player_name from (select striker,sum(runs_scored),count(distinct match_id),round((sum(runs_scored)*1.0)/count(distinct match_id),3) as bat_avg from (select striker,match_id,runs_scored from batsman_scored natural join ball_by_ball where match_id in (select match_id from match where season_id=5)) as foo group by striker) as foo,player where striker=player_id order by bat_avg desc,player_name limit 10;

--21--

with bar as (select country_name,sum(bat_avg) as sum_bat_avg from (select striker,round((sum(runs_scored)*1.0)/count(distinct match_id),3) as bat_avg from (select striker,match_id,runs_scored from batsman_scored natural join ball_by_ball ) as foo group by striker) as foo,player where striker=player_id group by country_name),foo1 as (select country_name,count(player_id) as total_palyer from player group by country_name) select country_name from (select bar.country_name,round((sum_bat_avg*1.0/total_palyer),3) as country_batting_average from bar,foo1 where bar.country_name=foo1.country_name) as fooo where country_batting_average in (select distinct round((sum_bat_avg*1.0/total_palyer),3) as country_batting_average from bar,foo1 where bar.country_name=foo1.country_name order by country_batting_average desc limit 5) order by country_batting_average desc,country_name;
