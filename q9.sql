

select mid,oid,in_no,total_runs,bowler from
(select mid,oid,in_no,total_runs,bowler from
	(select match_id as mid,over_id as oid,innings_no as in_no,sum(runs) as total_runs from 
		(
		 (select match_id,over_id,innings_no,runs_scored as runs from batsman_scored) 
		  union all 
		 (select match_id,over_id,innings_no,extra_runs as runs from extra_runs)
		) 
	 as total1 group by match_id,over_id,innings_no
	)
	as total_r, 
	(select distinct match_id,over_id,innings_no,bowler from ball_by_ball) as bowlertable
	where mid=match_id and oid=over_id and in_no=innings_no
) 
as customtable where (mid,total_runs) in (select mid,max(total_runs) from customtable group by mid) order by mid;





select mid,total_runs as maximum_runs,player_name from
(select mid,oid,in_no,total_runs,bowler from
(select mid,oid,in_no,total_runs,bowler from
	(select match_id as mid,over_id as oid,innings_no as in_no,sum(runs) as total_runs from 
		(
		 (select match_id,over_id,innings_no,runs_scored as runs from batsman_scored) 
		  union all 
		 (select match_id,over_id,innings_no,extra_runs as runs from extra_runs)
		) 
	 as total1 group by match_id,over_id,innings_no
	)
	as total_r, 
	(select distinct match_id,over_id,innings_no,bowler from ball_by_ball) as bowlertable
	where mid=match_id and oid=over_id and in_no=innings_no
) 
as customtable where (mid,total_runs) in (select mid,max(total_runs) from 
(select mid,oid,in_no,total_runs,bowler from
	(select match_id as mid,over_id as oid,innings_no as in_no,sum(runs) as total_runs from 
		(
		 (select match_id,over_id,innings_no,runs_scored as runs from batsman_scored) 
		  union all 
		 (select match_id,over_id,innings_no,extra_runs as runs from extra_runs)
		) 
	 as total1 group by match_id,over_id,innings_no
	)
	as total_r, 
	(select distinct match_id,over_id,innings_no,bowler from ball_by_ball) as bowlertable
	where mid=match_id and oid=over_id and in_no=innings_no
) as tt
group by mid)
) as ttt,player
where player_id=bowler
order by mid,oid;
