-- 1. Leandro Trossard goals
-- The first example shows the goals scored by a player with the first name 'Harry'.

-- Modify it to show the game, team, player, gtime for all goals scored by player 'Leandro Trossard'

SELECT game,team,player,gtime
  FROM goal 
 WHERE player LIKE 'Harry%'


-- 2. Team names
-- The team for player Leandro Trossard has code 'BEL'

-- Show the id, teamname and coach for the team with code 'BEL'

SELECT id, teamname, coach
  FROM team
 WHERE id LIKE 'BE%'

-- 3. JOIN
-- You can combine the two steps into a single query with a JOIN.
/*
SELECT *
  FROM goal JOIN team ON goal.team=team.id
The FROM clause says to combine data from the goal table with that from the team table. The ON says how to figure out which rows in game go with which rows in team - the team from goal must match id from team.

Show the player, gtime and teamname for every goal with goal time (gtime) less than 8 minutes.
*/

SELECT player, gtime, teamname
  FROM goal JOIN team ON goal.team=team.id
 WHERE gtime < 8


-- 4. Coach Sébastien
-- Use the same JOIN as in the previous question.

-- Show the player, teamname and coach for every goal scored by a team with coach named 'Sébastien'

SELECT player, teamname, coach
  FROM goal JOIN team ON goal.team=team.id
 WHERE coach LIKE 'Sébastien%'


--5. Where's Harry?
-- For each goal by 'Harry Edward Kane' show the player, the game id and the city

SELECT player,game.id, city
  FROM goal JOIN game ON goal.game=game.id
 WHERE player = 'Harry Edward Kane'

-- 6. Games in Vancouver
-- List the player and team (short code) for every goal scored in 'Vancouver'

SELECT player,team
  FROM goal JOIN game ON goal.game=game.id
 WHERE city = 'Vancouver'

-- 7. Goal Scorer
-- You will need to join in another table to answer this question.

-- List the player and the teamname for every goal scored in 'Vancouver'

SELECT player,teamname
  FROM goal 
    INNER JOIN game ON goal.game=game.id
    INNER JOIN team ON goal.team=team.id
 WHERE city = 'Vancouver'

-- 8. Teams Playing on July 1st
-- The join condition

-- game JOIN team ON team.id = game.team1 OR team.id = game.team2
-- ensures we get two rows for every game, one for each team in the game.

-- For each team playing on 2026-07-01, show the city and the teamname

SELECT city,teamname
  FROM game
  JOIN team ON team.id = game.team1 OR team.id = game.team2
 WHERE game.played = '2026-07-01'

-- 9. Every goal on one day
-- For every goal scored on '2026-07-02' show the teamname, and the player who scored
SELECT team.teamname, goal.player
  FROM goal 
    INNER JOIN game ON goal.game=game.id
    INNER JOIN team ON goal.team=team.id
 WHERE game.played = '2026-07-02'

-- 10. Mexico City scorer positions
-- For every goal scored in Mexico City show the date played, the player and that player's position (pos)
SELECT played, player, pos 
  FROM goal 
  JOIN game ON goal.game = game.id 
  JOIN player ON goal.player = player.playername 
 WHERE city = 'Mexico City';

-- 11. Defenders score
-- For each goal scored by a defender, show the player, their teamname.
-- In the default query, notice that the goal.team (the side credited with the goal) might not match the player's team (the person who scored the goal). This happens when there is an "own-goal".

SELECT player, teamname
  FROM goal 
    JOIN player ON goal.player = player.playername
    JOIN team ON player.team = team.id
 WHERE pos = 'DEF';


-- 12. Extra time goals
-- For each goal scored in extra time, show the player, their position, teamname and city
-- An extra time goal is when the gtime is BETWEEN 91 AND 120.

SELECT player, pos, teamname, city
  FROM goal 
  JOIN game ON goal.game = game.id 
  JOIN player ON goal.player = player.playername 
  JOIN team ON player.team = team.id
 WHERE gtime >= 91 AND gtime <= 120;
