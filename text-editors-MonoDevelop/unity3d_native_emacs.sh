#!/bin/bash
#
# Invokes emacs using the emacsclient.
# See: http://www.emacswiki.org/emacs/EmacsClient
#

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
if [ "$FILE_LINE" == "-1" ]; then FILE_LINE="0"; fi

FILE_PATH=$(wine winepath -u "$WIN_FILE_PATH")
FILE_PATH="${FILE_PATH/dosdevices\/c:/drive_c}"

# You might need to change this path?
EMACS_CLIENT=/usr/bin/emacsclient

# Check to see if we need to open a new frame for the emacs client.
# (--alternate-editor will open emacs in the terminal if it's not told 
# to open a new windowed frame specifically with the -c arg.  If you
# use the -c arg for every call you get a million emacs windows.
# This is crazy behaviour from emacs if you ask me).
#
# Not sure how robust this method of determining if there's a windowed
# emacs running is.  If it doesn't work for you just comment out this 
# block and manually start emacs before you start editing files.
emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" | grep t
if [ "$?" = "1" ]; then
    FRAME_ARG=-c
else
    FRAME_ARG=
fi

# work out whether we have a file line argument when we run emacs 
if [ "$FILE_LINE" == "" ];
then
   FILE_LINE_ARG=
else
   FILE_LINE_ARG=+$FILE_LINE
fi

# open the file in an existing emacs window.
exec $EMACS_CLIENT $FRAME_ARG -n --alternate-editor="" $FILE_LINE_ARG "$FILE_PATH"


