#!/bin/bash

function quit() {
  bspc node -c
}

while true
do
  echo "%{A:exit:}X%{A} O _ | $(xdotool getactivewindow getwindowname)"
done
