#!/bin/bash
if [ -z $(pidof waybar) ]; then
  waybar -c /home/david/.config/waybar/config -s /home/david/.config/waybar/style.css &
else
  pkill waybar
fi
