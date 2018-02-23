--1--

SELECT player_name FROM player WHERE country_name = 'England' AND batting_hand = 'Left-hand bat' ORDER BY player_name;

--2--

SELECT player_name, (DATE_PART('year','2018-12-02'::date) - DATE_PART('year', dob)) AS player_age FROM player WHERE bowling_skill = 'Legbreak googly' AND (DATE_PART('year','2018-12-02'::date) - DATE_PART('year', dob)) >= 28 ORDER BY player_age DESC;

--3--



--4--



--5--



--6--



--7--



--8--



--9--



--10--



--11--



--12--



--13--



--14--



--15--



--16--



--17--



--18--



--19--



--20--



--21--
