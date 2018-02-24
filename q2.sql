select player_name,player_age from (select player_name,DATE_PART('year', age('2018-12-02',dob)) as player_age from player where bowling_skill='Legbreak googly') as age_table where player_age>=28 order by player_age desc,player_name asc;

select player_name,player_age from (select player_name,EXTRACT(year from age(timestamp '2018-12-02',dob)) as player_age from player where bowling_skill='Legbreak googly') as age_table where player_age>=28 order by player_age desc,player_name asc;
