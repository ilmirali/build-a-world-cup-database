#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    
    # get winner id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    echo $WINNER, $WINNER_ID
    
    # if winner id not found
    if [[ -z $WINNER_ID ]]
    then
      # insert winner
      INSERT_WINNER_ID=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")

      # get new winner id
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
      echo $WINNER, $WINNER_ID
    fi
  

    # get opponent id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    echo $OPPONENT, $OPPONENT_ID
    
    # if opponent id not found
    if [[ -z $OPPONENT_ID ]]
    then
      # insert opponent
      INSERT_OPPONENT_ID=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")

      # get new opponent id
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
      echo $OPPONENT, $OPPONENT_ID
    fi
    
    # insert row into games
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YEAR, $ROUND, $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS')")
    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then
        echo Insert into games was successed
    fi

  fi
done




