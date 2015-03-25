#!/bin/sh
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

FILE_PATH=$(winepath -u "$WIN_FILE_PATH")
if [[ "$WIN_FILE_PATH" == *.sln ]]; then FILE_PATH=$(dirname "$FILE_PATH"); fi
SLN_DIR="${FILE_PATH%%/Assets/*}"
SLN_PATH=$(find "$SLN_DIR" -maxdepth 1 -name "*-csharp.sln")
SLN_NAME="${SLN_PATH#${SLN_DIR}/}"
SLN_NAME="${SLN_NAME#$?}"
LOCAL_FILE_PATH="${FILE_PATH#$SLN_DIR}"
LOCAL_FILE_DIR=$(dirname "$LOCAL_FILE_PATH")
FILE_NAME="${LOCAL_FILE_PATH#${LOCAL_FILE_DIR}/}"

export WINEPREFIX=~/.local/share/wineprefixes/unity3d/
if [[ $FILE_PATH == *".js" ]]
then
	SLN_NAME="${SLN_NAME/-csharp/}"
	PREV_SLN_NAME=$(head -n 1 "${SLN_DIR}/sln_name_of_last_monodevelop_call_js")
	
	WIN_SLN_DIR="$(winepath -w "$SLN_DIR")"

	MD_PATH="${WINEPREFIX}drive_c/Program Files/Unity/MonoDevelop/bin/MonoDevelop.exe"
	
	if [ "$(pidof MonoDevelop.exe)" ] && [ $PREV_SLN_NAME == $SLN_NAME ]
	then wine "$MD_PATH" "$WIN_FILE_PATH;$FILE_LINE"
	else wine "$MD_PATH" "${WIN_SLN_DIR}\\$SLN_NAME $WIN_FILE_PATH;$FILE_LINE"
	fi

	echo "$SLN_NAME" > "${SLN_DIR}/sln_name_of_last_monodevelop_call_js"
	
	exit 0
fi

COUNT="${LOCAL_FILE_PATH//[^\/]}"
COUNT="${#COUNT}"
COUNT="$((COUNT - 2))"

BACKWARD_SLN_DIR=""
for i in $(seq 0 $COUNT); do BACKWARD_SLN_DIR="${BACKWARD_SLN_DIR}../"; done

ln -s "/" "${SLN_DIR}/Z:"
ln -s "${WINEPREFIX}dosdevices/c:" "${SLN_DIR}/C:"

cd "${SLN_DIR}$LOCAL_FILE_DIR"

PREV_SLN_NAME=$(head -n 1 "${SLN_DIR}/sln_name_of_last_monodevelop_call")

echo "$SLN_NAME" > "${SLN_DIR}/sln_name_of_last_monodevelop_call"

if [[ "$WIN_FILE_PATH" == *".sln" ]]
then
	if [ -z "$(pidof monodevelop)" ]
	then /bin/monodevelop "$SLN_NAME"
	fi
else
	if [ "$(pidof monodevelop)" ] && [ $PREV_SLN_NAME == $SLN_NAME ]
	then /bin/monodevelop "$FILE_NAME;$FILE_LINE"
	else /bin/monodevelop "${BACKWARD_SLN_DIR}$SLN_NAME $FILE_NAME;$FILE_LINE"
	fi
fi

exit 0
