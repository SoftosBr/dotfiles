#!/bin/bash

killall -q polybar 
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

CARD=$(brightnessctl | grep backlight | awk '{print $2}' | tr -d "'")

for m in $(polybar --list-monitors | cut -d":" -f1); do
   CARD=$CARD MONITOR=$m polybar --reload skybar &
done
