#!/usr/bin/bash

VERSION=1.0.0
TIPS_SHARE_DIR="$HOME/.local/share/linux-tips"

if [ "$1" = "--version" ]
then
    echo "Version $VERSION"
    exit 0
fi
if [ -z "$1" ]
    then
	echo "No argument supplied"
else
    FILE="$TIPS_SHARE_DIR/$1-tips"
    if [[ -f "$FILE" ]]
	then
            cat "$FILE"
    else
	    echo "ERROR :: Tips for $1 does not exist !"
	    echo "-----------------------------"
	    echo "List of the available tips :"
	    echo "-----------------------------"
	    ls -1 $TIPS_SHARE_DIR | nl | sed 's/^\s*\([0-9]\+\)\s\(.*\)$/\1| \2/'
    fi
    
fi

