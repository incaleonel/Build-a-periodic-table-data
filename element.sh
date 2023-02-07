
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ $1 ]]
then
  #verify if is a number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ROW=$($PSQL"SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius 
    FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id)
    WHERE atomic_number= $1")
  else
    ROW=$($PSQL"SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius 
    FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id)
    WHERE symbol ='$1' OR name='$1'")
  fi
  if [[ -z $ROW ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$ROW" | while IFS="|" read  ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    done
  fi
else
  #if do not provide an argument
  echo "Please provide an element as an argument."
fi


