#!/bin/bash

connected_devices=$(bluetoothctl devices Connected | grep "Device " | awk '{print $2}')

if [ -z "$connected_devices" ]; then
    echo "%{F#cfb793}N/A%%{F-}"
    exit 0
fi

battery_info=""
for mac in $connected_devices; do
    battery=$(echo "info $mac" | bluetoothctl | grep "Battery Percentage" | sed 's/.*(\([0-9]*\)).*/\1/')
    name=$(echo "info $mac" | bluetoothctl | grep "Name" | cut -d: -f2 | xargs)
    
    if [ -n "$battery" ] && [ "$battery" != "(unknown)" ]; then
        battery_info="${battery}"
        break  # Show first matching headphones
    fi
done

if [ -n "$battery_info" ]; then
    if [ "$battery_info" -le "20" ]; then
        echo "%{F#f08533}%{T2}󰥇%{F-}%{T1} $battery_info%"
    elif [ "$battery_info" -le "40" ]; then
        echo "%{F#f08533}%{T2}󰥀%{F-}%{T1} $battery_info%"
    elif [ "$battery_info" -le "60" ]; then
        echo "%{F#bc9ed0}%{T2}󰥂%{F-}%{T1} $battery_info%"
    elif [ "$battery_info" -le "80" ]; then
        echo "%{F#bc9ed0}%{T2}󰥄%{F-}%{T1} $battery_info%"
    else
        echo "%{F#9fd356}%{T2}󰥈%{F-}%{T1} $battery_info%"
    fi
else
    echo "%{F#cfb793}%{T2}󰥊%{F-}%{T1} --%"
fi
