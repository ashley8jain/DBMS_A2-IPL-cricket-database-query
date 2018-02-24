#answer
select player_name,runs_scored from player,
(select striker,sum(runs) as runs_scored from  ball_by_ball,((select match_id,over_id,ball_id,innings_no,runs_scored as runs from batsman_scored where runs_scored>0) ) as runs_score
where runs_score.match_id = ball_by_ball.match_id and runs_score.over_id = ball_by_ball.over_id and runs_score.ball_id = ball_by_ball.ball_id and runs_score.innings_no = ball_by_ball.innings_no
group by striker) as total_runs
where striker=player_id and striker in
	(select striker from
		(select striker,max(runs_scored) as max_runs from
			(select runs_score.match_id,striker,sum(runs) as runs_scored from  ball_by_ball,((select match_id,over_id,ball_id,innings_no,runs_scored as runs from batsman_scored where runs_scored>0) ) as runs_score
			where runs_score.match_id = ball_by_ball.match_id and runs_score.over_id = ball_by_ball.over_id and runs_score.ball_id = ball_by_ball.ball_id and runs_score.innings_no = ball_by_ball.innings_no
			group by runs_score.match_id,striker)
		as total_runs group by striker) as fifty
	where max_runs>=50)
order by runs_scored desc,player_name;

select player_name,runs_scored from player,(select striker,sum(runs) as runs_scored from  ball_by_ball,((select match_id,over_id,ball_id,innings_no,runs_scored as runs from batsman_scored where runs_scored>0) ) as runs_score where runs_score.match_id = ball_by_ball.match_id and runs_score.over_id = ball_by_ball.over_id and runs_score.ball_id = ball_by_ball.ball_id and runs_score.innings_no = ball_by_ball.innings_no group by striker) as total_runs where striker=player_id and striker in (select striker from (select striker,max(runs_scored) as max_runs from (select runs_score.match_id,striker,sum(runs) as runs_scored from  ball_by_ball,((select match_id,over_id,ball_id,innings_no,runs_scored as runs from batsman_scored where runs_scored>0) ) as runs_score where runs_score.match_id = ball_by_ball.match_id and runs_score.over_id = ball_by_ball.over_id and runs_score.ball_id = ball_by_ball.ball_id and runs_score.innings_no = ball_by_ball.innings_no group by runs_score.match_id,striker) as total_runs group by striker) as fifty where max_runs>=50) order by runs_scored desc,player_name;


#half century striker
select striker from
(select striker,max(runs_scored) as max_runs from
(select runs_score.match_id,striker,sum(runs) as runs_scored from  ball_by_ball,((select match_id,over_id,ball_id,innings_no,runs_scored as runs from batsman_scored where runs_scored>0) ) as runs_score
where runs_score.match_id = ball_by_ball.match_id and runs_score.over_id = ball_by_ball.over_id and runs_score.ball_id = ball_by_ball.ball_id and runs_score.innings_no = ball_by_ball.innings_no
group by runs_score.match_id,striker) as total_runs group by striker) as fifty
where max_runs>=50;
