#!/bin/bash

# Variable to log errors
LOG_FILE="ping_errors.log"

# List of what to ping
HOSTS=(
    "google.com"
    "yahoo.com"
    "tert45gfddgfg"
)

# Clean old errors
> "$LOG_FILE"

# Function to ping hosts
Ping_Hosts()
{
    local HOST="$1"
    echo "Pinging $HOST..."

    if ping -c 2 -W 5 "$HOST" &> /dev/null
    then
        echo "$HOST is reachable!"
    else
        echo "$HOST is unreachable"
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $HOST is unreachable" >> "$LOG_FILE"
    fi
}

# Loop through HOSTS calling the Ping_Host Function
for HOST in "${HOSTS[@]}"
do
    Ping_Hosts "$HOST"
    echo "◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉"
done


