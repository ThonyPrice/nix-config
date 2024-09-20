#!/bin/bash

nix_logo=(
  icon=$NIX
  icon.font="$FONT:Black:20.0"
  icon.color=$BLUE
  padding_right=15
  label.drawing=off
  click_script="$POPUP_CLICK_SCRIPT"
  popup.height=35
)

sketchybar --add item nix.logo left                  \
           --set nix.logo "${nix_logo[@]}"
