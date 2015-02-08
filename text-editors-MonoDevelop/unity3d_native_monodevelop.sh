#!/bin/sh
if [ -z "$1" ]; then exit 1; fi;

FILE_PATH=$(winepath -u "$1")
FILE_LINE="$2"
SLN_DIR="${FILE_PATH%%Assets/*}"
SLN_PATH=$(find "$SLN_DIR" -maxdepth 1 -name "*-csharp.sln")
SLN_NAME="${SLN_PATH#$SLN_DIR}"
LOCAL_FILE_PATH="${FILE_PATH#$SLN_DIR}"
LOCAL_FILE_DIR=$(dirname "$LOCAL_FILE_PATH")
FILE_NAME="${LOCAL_FILE_PATH#$LOCAL_FILE_DIR}"
FILE_NAME="${FILE_NAME#?}"

#to go back ../ for number of folders in which file is -1
COUNT="${LOCAL_FILE_PATH//[^\/]}"
COUNT="${#COUNT}"
COUNT="$((COUNT - 1))"

BACKWARD_SLN_DIR = ""
for i in $(seq 0 $COUNT); do BACKWARD_SLN_DIR="${BACKWARD_SLN_DIR}../"; done

ln -s "/" "${SLN_DIR}/Z:"
cd "${SLN_DIR}/$LOCAL_FILE_DIR"

PREV_SLN_NAME=$(head -n 1 "${SLN_DIR}/sln_name_of_last_monodevelop_call")

if [ "$(pidof monodevelop)" ] && [ $PREV_SLN_NAME == $SLN_NAME ]
then /bin/monodevelop "$FILE_NAME;$FILE_LINE"
else /bin/monodevelop "${BACKWARD_SLN_DIR}/$SLN_NAME $FILE_NAME;$FILE_LINE"
fi

echo "$SLN_NAME" > "${SLN_DIR}/sln_name_of_last_monodevelop_call"

exit 0
