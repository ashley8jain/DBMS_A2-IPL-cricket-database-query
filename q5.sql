select player_name from (select distinct striker from (select match_id,over_id,ball_id,innings_no from wicket_taken where kind_out='bowled') as foo natural join ball_by_ball) as bar,player where striker=player_id order by player_name asc;

-- old query
select player_name from player where player_id in (select distinct(bowler) from ball_by_ball) order by player_name asc;
