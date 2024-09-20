#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

echo "Space: ${1}."
echo "Focused ws: ${AEROSPACE_FOCUSED_WORKSPACE}."
echo "Name: ${NAME}."

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on
else
    sketchybar --set $NAME background.drawing=off
fi
