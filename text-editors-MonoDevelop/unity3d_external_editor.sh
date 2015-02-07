#!/bin/sh
if [ -z "$1" ]; then exit 1; fi;
#/bin/subl "`wine winepath -u "$1"`:$2" #replace subl with any other text editor, but check how its command line arguments should be formatted!!
export WINEPREFIX=~/.local/share/wineprefixes/unity3d/
wine ~/.local/share/wineprefixes/unity3d/drive_c/Program\ Files/Unity/MonoDevelop/bin/monodevelop.exe "$1;$2"
exit 0 
