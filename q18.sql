select player_name from player,match,
(select player_match.match_id,team_id,striker from player_match,
(select runs_score.match_id,striker,sum(runs) as runs_scored from  ball_by_ball,((select match_id,over_id,ball_id,innings_no,runs_scored as runs from batsman_scored where runs_scored>0) union all (select match_id,over_id,ball_id,innings_no,extra_runs as runs from extra_runs)) as runs_score
where runs_score.match_id = ball_by_ball.match_id and runs_score.over_id = ball_by_ball.over_id and runs_score.ball_id = ball_by_ball.ball_id and runs_score.innings_no = ball_by_ball.innings_no
group by runs_score.match_id,striker) as total_runs
where runs_scored>=100 and total_runs.match_id=player_match.match_id and player_id=striker) as century
where century.match_id=match.match_id and team_id!=match_winner and player_id=striker
order by player_name;


-- old
select player_name from player,match,(select player_match.match_id,team_id,striker from player_match,(select runs_score.match_id,striker,sum(runs) as runs_scored from  ball_by_ball,((select match_id,over_id,ball_id,innings_no,runs_scored as runs from batsman_scored where runs_scored>0) union all (select match_id,over_id,ball_id,innings_no,extra_runs as runs from extra_runs)) as runs_score where runs_score.match_id = ball_by_ball.match_id and runs_score.over_id = ball_by_ball.over_id and runs_score.ball_id = ball_by_ball.ball_id and runs_score.innings_no = ball_by_ball.innings_no group by runs_score.match_id,striker) as total_runs where runs_scored>=100 and total_runs.match_id=player_match.match_id and player_id=striker) as century where century.match_id=match.match_id and team_id!=match_winner and player_id=striker order by player_name;

-- new
select player_name from player,match,
(select player_match.match_id,team_id,striker from player_match,
(select runs_score.match_id,striker,sum(runs) as runs_scored from  ball_by_ball,(select match_id,over_id,ball_id,innings_no,runs_scored as runs from batsman_scored where runs_scored>0) as runs_score
where runs_score.match_id = ball_by_ball.match_id and runs_score.over_id = ball_by_ball.over_id and runs_score.ball_id = ball_by_ball.ball_id and runs_score.innings_no = ball_by_ball.innings_no
group by runs_score.match_id,striker) as total_runs
where runs_scored>=100 and total_runs.match_id=player_match.match_id and player_id=striker) as century
where century.match_id=match.match_id and team_id!=match_winner and player_id=striker
order by player_name;


select player_name from player,match,(select player_match.match_id,team_id,striker from player_match,(select runs_score.match_id,striker,sum(runs) as runs_scored from  ball_by_ball,(select match_id,over_id,ball_id,innings_no,runs_scored as runs from batsman_scored where runs_scored>0) as runs_score where runs_score.match_id = ball_by_ball.match_id and runs_score.over_id = ball_by_ball.over_id and runs_score.ball_id = ball_by_ball.ball_id and runs_score.innings_no = ball_by_ball.innings_no group by runs_score.match_id,striker) as total_runs where runs_scored>=100 and total_runs.match_id=player_match.match_id and player_id=striker) as century where century.match_id=match.match_id and team_id!=match_winner and player_id=striker order by player_name;
