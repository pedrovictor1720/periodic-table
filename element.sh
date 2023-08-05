#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

#LÊ O VALOR DIGITADO PELO USUÁRIO
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  #CONFERINDO SE O VALOR DIGITADO É UM NÚMERO
  re='^[0-9]+$'
  if [[ $1 =~ $re ]]
  #SE FOR...
  then
    SEARCH=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1")
    if [[ -z $SEARCH ]]
    then
       echo "I could not find that element in the database."
    else
      echo "$SEARCH" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING BAR BOILING BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done 
    fi
  else
    #SE NÃO FOR...
    SEARCH=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$1' OR symbol='$1'")
    if [[ -z $SEARCH ]]
    then
      echo "I could not find that element in the database."
    else
     echo "$SEARCH" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING BAR BOILING BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done 
    fi
  fi
fi
#1234
