#!/bin/bash
# ---> Display script name <---
echo "Script Name -->  $0"
# ---> Create Directory & Input Validation <---
if [[ $# -eq 0 ]]
    then
        echo "You must provide one parameter"
    elif [[ $# -gt 1 ]]
        then
            echo "You must provide only one parameter"
    else
        test -d $1
        if [ "$?" -eq "0" ]
            then
                echo "$1 <-- Already exists"
                exit 1 # exit code NOTOK.
            else
                mkdir $1
                echo "$1 <-- directory created"
                exit 0 # exit code OK
        fi
fi


