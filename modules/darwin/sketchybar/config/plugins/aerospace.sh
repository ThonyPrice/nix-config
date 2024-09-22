#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

get_icon() {
    case "$1" in
        1) echo "";;
        2) echo "";;
        3) echo "";;
        4) echo "󰭻";;
        5) echo "";;
        6) echo "";;
        7) echo "";;
        8) echo "";;
        9) echo "󰆼";;
        A) echo "";;
        M) echo "";;
        *) echo "";;
    esac
}

icon=$(get_icon "$1")
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on icon="$icon" icon.color=$GREEN
else
    sketchybar --set $NAME background.drawing=off icon="$icon" icon.color=$WHITE
fi
