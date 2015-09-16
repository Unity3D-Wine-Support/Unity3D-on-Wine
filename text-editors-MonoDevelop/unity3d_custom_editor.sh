#!/bin/bash

# to debug uncomment the next line
# set -x

if [ -z "$1" ]; then exit 1; fi

if [ "$1" == "--nologo" ]
then
	WIN_FILE_PATH="${3%;*}"
	FILE_LINE="${3##*;}"
else
	WIN_FILE_PATH="$1"
	FILE_LINE="$2"
fi
if [ $FILE_LINE == "-1" ]; then FILE_LINE="0"; fi

FILE_PATH=$(wine winepath -u "$WIN_FILE_PATH")
FILE_PATH="${FILE_PATH/dosdevices\/c:/drive_c}"

#replace subl with custom editor (watch out for its argument formatting!)
EDITOR="subl"
EDITOR_PATH="$(which $EDITOR)"

"$EDITOR_PATH" "$FILE_PATH:$FILE_LINE"

