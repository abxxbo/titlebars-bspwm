#!/bin/bash


# run lemonbar script

if [[ "$#" == "0" ]]; then
  bash ~/.config/bar/bar.sh | lemonbar -B "#000" -d |
    while read line; do
      IFS=$'\t' read -ra cmd <<< "${line}"
      case "${cmd[0]}" in
        exit) bspc node -c ;;
        maxi) bspc node -t fullscreen ;;
        *) ;;
      esac
    done &
else
  # 1st argument
  case $1 in
    "--help")
      # cat << EOF dont work :(
      echo "Usage: titlebars.sh [Background Color] [Position -- left, right, top, or bottom]"
      exit
      ;;
    *)
      ;;
  esac
  # 2st argument
  case $2 in
    "left")
      ;;
    "right")
      ;;
    "top")
      ;;
    "bottom")
      ;;
    *)
      echo "what?"
      exit
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
