#!/bin/bash

bar=20971524

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
