-- 5




-- 4
with bar as (select country_name,sum(bat_avg) as sum_bat_avg from (select striker,round((sum(runs_scored)*1.0)/count(distinct match_id),3) as bat_avg from (select striker,match_id,runs_scored from batsman_scored natural join ball_by_ball ) as foo group by striker) as foo,player where striker=player_id group by country_name),foo1 as (select country_name,count(player_id) as total_palyer from player group by country_name) select country_name from (select bar.country_name,round((sum_bat_avg*1.0/total_palyer),3) as country_batting_average from bar,foo1 where bar.country_name=foo1.country_name) as fooo where country_batting_average in (select distinct round((sum_bat_avg*1.0/total_palyer),3) as country_batting_average from bar,foo1 where bar.country_name=foo1.country_name order by country_batting_average desc limit 5) order by country_batting_average desc,country_name;

-- 3

select country_name,country_batting_average from

(
  select bar.country_name,round((sum_bat_avg*1.0/total_palyer),3) as country_batting_average from
  (select country_name,sum(bat_avg) as sum_bat_avg from
    (select striker,round((sum(runs_scored)*1.0)/count(distinct match_id),3) as bat_avg from (select striker,match_id,runs_scored from batsman_scored natural join ball_by_ball ) as foo group by striker
    ) as foo,player where striker=player_id group by country_name
  ) as bar,
  (select country_name,count(player_id) as total_palyer from player group by country_name) as foo1 where bar.country_name=foo1.country_name
) as fooo where country_batting_average in
(
  select distinct round((sum_bat_avg*1.0/total_palyer),3) as country_batting_average from
  (select country_name,sum(bat_avg) as sum_bat_avg from
    (select striker,round((sum(runs_scored)*1.0)/count(distinct match_id),3) as bat_avg from (select striker,match_id,runs_scored from batsman_scored natural join ball_by_ball ) as foo group by striker
    ) as foo,player where striker=player_id group by country_name
  ) as bar,
  (select country_name,count(player_id) as total_palyer from player group by country_name) as foo1 where bar.country_name=foo1.country_name order by country_batting_average desc limit 5

) order by country_batting_average desc,country_name;


-- 2

select bar.country_name,round((sum_bat_avg*1.0/total_palyer),3) as country_batting_average from
(select country_name,sum(bat_avg) as sum_bat_avg from
  (select striker,round((sum(runs_scored)*1.0)/count(distinct match_id),3) as bat_avg from (select striker,match_id,runs_scored from batsman_scored natural join ball_by_ball ) as foo group by striker
  ) as foo,player where striker=player_id group by country_name
) as bar,
(select country_name,count(player_id) as total_palyer from player group by country_name) as foo1 where bar.country_name=foo1.country_name order by country_batting_average desc;



-- 1

select country_name,sum(bat_avg) as sum_bat_avg from
  (select striker,round((sum(runs_scored)*1.0)/count(distinct match_id),3) as bat_avg from (select striker,match_id,runs_scored from batsman_scored natural join ball_by_ball ) as foo group by striker
) as foo,player where striker=player_id group by country_name;
