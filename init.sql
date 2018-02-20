--TABLE 1--

CREATE TABLE player(player_id int PRIMARY KEY, player_name text, dob date, batting_hand text, bowling_skill text, country_name text);

COPY player(player_id, player_name, dob, batting_hand, bowling_skill, country_name) FROM '/Users/ram/Downloads/Assignment_2/player.csv' DELIMITER ',';

--TABLE 2--

CREATE TABLE team(team_id int PRIMARY KEY, name text);

COPY team(team_id, name) FROM '/Users/ram/Downloads/Assignment_2/team.csv' DELIMITER ',';

--TABLE 3--

CREATE TABLE match(match_id int PRIMARY KEY, team_1 int, team_2 int, match_date date, season_id int, venue text, toss_winner int, toss_decision text, win_type text, win_margin int, outcome_type text, match_winner int, man_of_the_match int);

COPY match(match_id, team_1, team_2, match_date, season_id, venue, toss_winner, toss_decision, win_type, win_margin, outcome_type, match_winner, man_of_the_match) FROM '/Users/ram/Downloads/Assignment_2/match.csv' DELIMITER ',';

--TABLE 4--

CREATE TABLE player_match(match_id int, player_id int, role text, team_id int, CONSTRAINT player_match_PK PRIMARY KEY (match_id, player_id));

COPY player_match(match_id, player_id, role, team_id) FROM '/Users/ram/Downloads/Assignment_2/player_match.csv' DELIMITER ',';

--TABLE 5--

CREATE TABLE ball_by_ball(match_id int, over_id int, ball_id int, innings_no int, team_batting int, team_bowling int, striker_batting_position int, striker int, non_striker int, bowler int, CONSTRAINT ball_by_ball_pk PRIMARY KEY(match_id, over_id, ball_id, innings_no));

COPY ball_by_ball(match_id, over_id, ball_id, innings_no, team_batting, team_bowling, striker_batting_position, striker, non_striker, bowler) FROM '/Users/ram/Downloads/Assignment_2/ball_by_ball.csv' DELIMITER ',';

--TABLE 6--

CREATE TABLE batsman_scored(match_id int, over_id int, ball_id int, runs_scored int, innings_no int, CONSTRAINT batsman_scored_pk PRIMARY KEY(match_id, over_id, ball_id, innings_no));

COPY batsman_scored(match_id, over_id, ball_id, runs_scored, innings_no) FROM '/Users/ram/Downloads/Assignment_2/batsman_scored.csv' DELIMITER ',';

--TABLE 7--

CREATE TABLE wicket_taken(match_id int, over_id int, ball_id int, player_out int, kind_out text, innings_no int, CONSTRAINT wicket_taken_pk PRIMARY KEY(match_id,over_id,ball_id,innings_no));

COPY wicket_taken(match_id, over_id, ball_id, player_out, kind_out, innings_no) FROM '/Users/ram/Downloads/Assignment_2/wicket_taken.csv' DELIMITER ',';

--TABLE 8--

CREATE TABLE extra_runs(match_id int, over_id int, ball_id int, extra_type text, extra_runs int, innings_no int, CONSTRAINT extra_runs_pk PRIMARY KEY(match_id, over_id, ball_id, innings_no));

COPY extra_runs(match_id, over_id, ball_id, extra_type, extra_runs, innings_no) FROM '/Users/ram/Downloads/Assignment_2/extra_runs.csv' DELIMITER ',';
