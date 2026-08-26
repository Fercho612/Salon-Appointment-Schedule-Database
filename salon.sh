#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"


SERVICES=$($PSQL "SELECT service_id, name FROM services;")

LIST_SERVICE(){
  echo "$SERVICES" | while IFS="|" read ID SERVICE
  do
    echo "$ID) $SERVICE" 
  done
}

LIST_SERVICE
read SERVICE_ID_SELECTED


while [[ -z $($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED;") ]]
do
  echo -e "\nI could not find that service. What would you like today?"
  LIST_SERVICE 
  read SERVICE_ID_SELECTED
done

echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE
if [[ -z $($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';") ]]
then
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  
  INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME');")
fi

SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED;")
if [[ -z $CUSTOMER_NAME ]]
then
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';")
fi

echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
read SERVICE_TIME

CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")

echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME.\n"

#SERVICE_TIME