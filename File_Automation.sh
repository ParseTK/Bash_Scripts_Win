#!/bin/bash

# ---> Get User Input <---
read -p "Enter file name. To end type q: " INPUT
# ---> Creates files until user enters q <---
while [[ $INPUT != "q" ]]
    do
        touch "$INPUT"
        echo "Created --> $INPUT"
        read -p "Enter file name. To end type q: " INPUT
    done
echo "exiting..."
sleep 2
exit 0 # Exit code OK.
