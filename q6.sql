select match_id,team_1,name as team_2,winning_team_name,win_margin from (select match_id,name as team_1,team_2,winning_team_name,win_margin from (select match_id,team_1,team_2,name as winning_team_name,win_margin from match,team where win_margin>=60 and team.team_id=match.match_winner) as foo,team where team_1=team_id) as bar,team where team_2=team_id order by win_margin asc,match_id asc;

-- old
select match_id,team_1,team_2,name as winning_team_name,win_margin from match,team where win_margin>=60 and team.team_id=match.match_winner order by win_margin asc,match_id asc;
