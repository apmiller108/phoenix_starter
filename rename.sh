#!/bin/bash

set -e
set -o pipefail

NEW_OTP=$1
NEW_NAME=""

# New name argument is required
if [ $# -eq 0 ]; then
    echo "Please provide a name in snake case. See readme for instructions"\
      "https://github.com/apmiller108/phoenix_starter/blob/master/README.md"
    exit 64
fi

CURRENT_NAME="PhoenixStarter"
CURRENT_OTP="phoenix_starter"

# Split snake cased new name into array of words.
IFS="_" read -a words <<< "$NEW_OTP"

# Upercase all the words and concatenate them together. This derives the app's
# CamelCase module name.
for word in "${words[@]}"; do
  word="$(tr '[:lower:]' '[:upper:]' <<< ${word:0:1})${word:1}"
  NEW_NAME="$NEW_NAME$word"
done

# Confirm name change
echo -e -n "Please confirm this is correct:\nNew name: ${NEW_NAME}\n"\
  "New OTP name: $NEW_OTP\nContinue? [y/n]"

read -p "" ANSWER

if [ "$ANSWER" = "y" ]; then
  grep -l $CURRENT_NAME -r . --exclude-dir=_build --exclude README.md \
    | xargs sed -i '' -e "s/$CURRENT_NAME/$NEW_NAME/g"
  grep -l $CURRENT_OTP -r . --exclude-dir=_build --exclude README.md \
    | xargs sed -i '' -e "s/$CURRENT_OTP/$NEW_OTP/g"

  mv lib/$CURRENT_OTP lib/$NEW_OTP
  mv lib/$CURRENT_OTP.ex lib/$NEW_OTP.ex
  echo -e "Completed renaming"
else 
  echo -e "exiting"
  exit 0
fi
