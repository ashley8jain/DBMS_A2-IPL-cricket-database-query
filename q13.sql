

with venue_wides as (select venue,count(venue) as number from match,extra_runs where extra_type='wides' and extra_runs.match_id=match.match_id group by venue order by venue) select venue from venue_wides where number in (select max(number) from venue_wides) limit 1;
