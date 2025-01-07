#!/bin/bash 

if ! command -v brightnessctl &> /dev/null; then 
	echo "brightnessctl not found! Please install "
	exit 1
fi

device=$(brightnessctl -l | grep -i 'kbd_backlight' | sed -e "s/'//g" | awk '{print $2}')

if [ -z "$device" ]; then
	echo "Not found any keyboard with backlight"
	exit 1
fi 	

if [ "$1" == "up" ]; then
	brightnessctl -d "$device" set +10%
elif [ "$1" == "down" ]; then
    	brightnessctl -d "$device" set 10%-
else
    echo "Uso: $0 up|down"
    exit 1
fi


