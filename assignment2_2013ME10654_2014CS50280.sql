--1--

SELECT player_name FROM player WHERE country_name = 'England' AND batting_hand = 'Left-hand bat' ORDER BY player_name ASC;

--2--

SELECT player_name, (DATE_PART('year','2018-12-02'::date) - DATE_PART('year', dob)) AS player_age FROM player WHERE bowling_skill = 'Legbreak googly' AND (DATE_PART('year','2018-12-02'::date) - DATE_PART('year', dob)) >= 28 ORDER BY player_age DESC, player_name ASC;

--3--

SELECT match_id, toss_winner FROM match WHERE toss_decision = 'bat' ORDER BY match_id ASC;

--4--

SELECT * FROM (SELECT over_id, SUM(runs_scored) AS runs_scored FROM batsman_scored WHERE match_id = 335987 GROUP BY over_id ORDER BY over_id DESC) AS smthng WHERE runs_scored <= 7 ORDER BY runs_scored DESC, over_id ASC;

--5--

SELECT player_name FROM player, (SELECT DISTINCT bowler FROM ball_by_ball) AS q1 WHERE player.player_id = q1.bowler ORDER BY player_name ASC;

--6--

SELECT match_id, team_1, team_2, match_winner, win_margin FROM match WHERE win_margin >= 60 ORDER BY win_margin, match_id ASC;

--7--

SELECT player_name FROM player WHERE batting_hand = 'Left-hand bat' AND (DATE_PART('year','2018-12-02'::date) - DATE_PART('year', dob)) < 30 ORDER BY player_name ASC;

--8--

SELECT match_id, SUM(runs_scored) AS total_runs FROM batsman_scored GROUP BY match_id ORDER BY match_id ASC;

--9--



--10--

SELECT player_name, number FROM (SELECT player_out, count(*) as number FROM wicket_taken WHERE kind_out = 'run out' GROUP BY player_out) AS foo, player WHERE foo.player_out = player.player_id ORDER BY number DESC, player_name ASC;

--11--

SELECT kind_out as out_type, count(*) as number FROM wicket_taken GROUP BY kind_out ORDER BY number DESC, out_type ASC;

--12--

SELECT name, count as number from team, (SELECT match_winner , count(*) AS count FROM match GROUP BY match_winner) AS foo WHERE foo.match_winner = team.team_id ORDER BY name;

--13--

SELECT venue FROM (SELECT venue, count(*) as count FROM extra_runs, match WHERE extra_type='wides' AND match.match_id = extra_runs.match_id  GROUP BY match.venue ORDER BY count DESC, venue) AS foo limit 1;

--14--

SELECT venue FROM (SELECT venue, count(*) as count FROM match WHERE (toss_decision='field' AND toss_winner = match_winner) OR (toss_decision = 'bat' AND toss_winner != match_winner) GROUP BY venue ORDER BY count) AS foo ;

--15--



--16--



--17--



--18--



--19--



--20--



--21--
