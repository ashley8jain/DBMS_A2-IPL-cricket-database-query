select player_name,DATE_PART('year', age('2018-12-02',dob)) from player where batting_hand='Left-hand bat' and DATE_PART('year', age('2018-12-02',dob))<30 order by player_name asc;

select player_name,dob,EXTRACT(year from age(timestamp '2018-12-02',dob)) from player where batting_hand='Left-hand bat' and EXTRACT(year from age(timestamp '2018-12-02',dob))<30 order by player_name asc;
