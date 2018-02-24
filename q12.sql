-- old
select name,number from (select match_winner,count(match_winner) as number from match group by match_winner) as total_win,team where team_id=match_winner order by name;

--new
select name,count(name) from (select team_id from (select man_of_the_match,match_id from match) as foo,player_match where man_of_the_match=player_id and foo.match_id=player_match.match_id) as bar,team where bar.team_id=team.team_id group by team.team_id order by name asc;
