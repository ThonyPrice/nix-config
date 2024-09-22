#!/bin/sh


SPACE_ICONS=("" "" "" "󰭻" "" "" "" "" "")

sketchybar --add event aerospace_workspace_change

PLUGIN_DIR="$HOME/git/nix-config/modules/darwin/sketchybar/config/plugins" # Directory where all the plugin scripts are stored

for m in $(aerospace list-monitors | awk '{print $1}'); do
  for i in $(aerospace list-workspaces --monitor $m); do
    sid=$i
    space=(
      space="$sid"
      icon="${SPACE_ICONS[i-1]}"
      icon.padding_left=10
      icon.padding_right=10
      display=$m
      padding_left=2
      padding_right=2
      icon.highlight_color=$GREEN
      label.color=$GREY
      label.highlight_color=$WHITE
      label.font="$FONT:Regular:14.0"
      label.y_offset=-10
      background.color=$BACKGROUND_1
      background.border_color=$BACKGROUND_2
      label.drawing=off
      background.drawing=off
      click_script="aerospace workspace $sid"
      script="$PLUGIN_DIR/aerospace.sh $sid"
    )

    sketchybar --add space space.$sid left \
               --set space.$sid "${space[@]}" \
               --subscribe space.$sid aerospace_workspace_change

  done

  for i in $(aerospace list-workspaces --monitor $m --empty); do
    sketchybar --set space.$i display=0
  done

done

spaces_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.border_width=2
)

separator=(
  icon=􀆊
  icon.font="$FONT:Heavy:16.0"
  padding_left=10
  padding_right=8
  label.drawing=off
  associated_display=active
  icon.color=$WHITE
)

sketchybar --add bracket spaces_bracket '/space\..*/'  \
           --set spaces_bracket "${spaces_bracket[@]}" \
                                                       \
           --add item separator left                   \
           --set separator "${separator[@]}"
