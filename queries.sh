#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals) + SUM(opponent_goals) FROM games;")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo -e "$($PSQL "SELECT AVG(winner_goals) FROM games;")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo -e "$($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games;")"

echo -e "\nAverage number of goals in all games from both teams:"
echo -e "$($PSQL "SELECT ROUND(AVG(winner_goals) + AVG(opponent_goals), 16) FROM games;")"

echo -e "\nMost goals scored in a single game by one team:"
echo -e "$($PSQL "SELECT MAX(winner_goals) FROM games;")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo -e "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals >2;")"

echo -e "\nWinner of the 2018 tournament team name:"
echo -e "$($PSQL "SELECT name FROM games AS g JOIN teams AS t ON t.team_id=g.winner_id WHERE year=2018 AND round='Final';")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo -e "$($PSQL "SELECT DISTINCT(name) FROM teams AS t LEFT JOIN games AS g ON t.team_id=g.winner_id LEFT JOIN games AS gg ON t.team_id=gg.opponent_id WHERE (g.year=2014 OR gg.year=2014) AND (g.round='Eighth-Final' OR gg.round='Eighth-Final') ORDER BY name;")"

echo -e "\nList of unique winning team names in the whole data set:"
echo -e "$($PSQL "SELECT DISTINCT(name) FROM teams AS t JOIN games AS g ON t.team_id=g.winner_id ORDER BY name;")"

echo -e "\nYear and team name of all the champions:"
echo -e "$($PSQL "SELECT year, name FROM games AS g JOIN teams AS t ON g.winner_id=t.team_id WHERE round='Final' ORDER BY year;")"

echo -e "\nList of teams that start with 'Co':"
echo -e "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%';")"
echo -e ""
