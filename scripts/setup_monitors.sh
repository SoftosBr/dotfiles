#!/bin/bash

Main_Display="DisplayPort-1"
SECONDARY="HDMI-A-1"

getResolution(){
    monitor=$1
    resolution=$(xrandr | grep -A 1 "^$monitor connected" | awk 'NR==2{print $1}')
    echo "$resolution"
}

getRefreshRate(){
    monitor=$1
    refresh_rate=$(xrandr | grep -A 1 "^$monitor connected" | awk 'NR==2{for(i=2; i<=NF; i++) print $i}' | grep -Eo '[0-9]+([.][0-9]+)?' | sort -rn | awk '{for(i=1;i<=NF;i++) {if($i < 144) {print $i; exit }}}')
    echo "$refresh_rate"
}

if xrandr | grep "^$Main_Display connected" > /dev/null; then
    RESOLUTION=$(getResolution $Main_Display) 
    REFRESH_RATE=$(getRefreshRate $Main_Display)
    
    if [ -n "$RESOLUTION" ] && [ -n "$REFRESH_RATE" ]; then
        xrandr --output $Main_Display --mode $RESOLUTION --rate $REFRESH_RATE
    fi
fi

if xrandr | grep "^$SECONDARY connected" > /dev/null; then
    RESOLUTION=$(getResolution $SECONDARY) 
    REFRESH_RATE=$(getRefreshRate $SECONDARY)

    if [ -n "$RESOLUTION" ] && [ -n "$REFRESH_RATE" ]; then
        xrandr --output $SECONDARY --mode $RESOLUTION --rate $REFRESH_RATE --left-of $Main_Display
    fi
fi
