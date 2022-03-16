#!/bin/bash

#  __________________
# |__________________|
# |                  |
# |                  |
# |                  |
# |                  |
# |__________________|
#
# Titlebars for bspwm.


# Run our lemonbar script

function run_lemonbar(){
  if [[ "$#" == "0" ]]; then
    bash ~/.config/bar/bar.sh | lemonbar -B "#000" -d |
      while read line; do
        IFS=$'\t' read -ra cmd <<< "${line}"
        case "${cmd[0]}" in
          exit) bspc node -c ;; # Quit current app
          maxi) bspc node -t fullscreen ;; # Maximize to full screen
          *) ;; # Don't do anything
        esac
      done & # Run in background
  else
    bash ~/.config/bar/bar.sh | lemonbar -B $1 -d |
      while read line; do
        IFS=$'\t' read -ra cmd <<< "${line}"
        case "${cmd[0]}" in
          exit) bspc node -c ;;
          maxi) bspc node -t fullscreen ;;
          *) ;;
        esac
      done &
  fi
}

## Can be switched from top to one of these values
# top    (already here -- default),
# left   (left side of window),
# right  (right side of window),
# bottom (bottom side of window)
state="top"

if [[ "$#" == "0" ]]; then
  run_lemonbar
else
  case $2 in
    "left")
      ;;
    "right")
      ;;
    "top")
      echo "Already set to this."
      ;;
    "bottom")
      ;;
    *)
      echo "unrecognized command, please choose from one of the following: top, bottom, left, right"
      echo "Default setting is 'TOP'"
      exit
      ;;
  esac
  case $1 in
    "--help")
      echo "Usage: titlebars.sh [BG color] [Position on window: left, right, top (default) or bottom]"
      exit
      ;;
    *)
      run_lemonbar "$1"
      ;;
  esac
fi
  

bar=$(xdotool search "lemonbar")

while true
do
  title="$(xdotool getactivewindow getwindowname)"
  winsize="$(xwininfo -id `xdotool getactivewindow` | grep "Width: " | cut -c10-999)"
  winheight=$(echo "$(xwininfo -id `xdotool getactivewindow` | grep 'Absolute upper-left Y:' | cut -c27-999)" | bc)
  xpos="$(xwininfo -id `xdotool getactivewindow` | grep "Absolute upper-left X:" | cut -c27-999)"
  echo "$winsize / $title"

  # set width of window 
  # gravity, X, Y, width, height
  wmctrl -ir $bar -e 1,$xpos,$winheight,$winsize,20
done
