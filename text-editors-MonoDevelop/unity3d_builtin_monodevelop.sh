#!/bin/sh
if [ -z "$1" ]; then exit 1; fi;

#replace subl with custom editor (watch out for its argument formatting!)
#/bin/subl "`wine winepath -u "$1"`:$2"

export WINEPREFIX=~/.local/share/wineprefixes/unity3d/
wine ${WINEPREFIX}drive_c/Program\ Files/Unity/MonoDevelop/bin/MonoDevelop.exe "$1;$2"
exit 0
