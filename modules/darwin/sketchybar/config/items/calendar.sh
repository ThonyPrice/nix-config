#!/bin/sh

sketchybar --add item     calendar right                    \
           --set calendar icon=cal                          \
                          icon.font="$FONT:Black:13.0"      \
                          icon.padding_right=6              \
                          label.width=45                    \
                          label.align=right                 \
                          padding_left=10                   \
                          update_freq=30                    \
                          script="$PLUGIN_DIR/calendar.sh"  \
                          click_script="$PLUGIN_DIR/zen.sh" \
           --subscribe    calendar system_woke
