#!/bin/bash

connected_devices=$(bluetoothctl devices Connected | grep "Device " | awk '{print $2}')

if [ -z "$connected_devices" ]; then
    echo "N/A%"
    exit 0
fi

battery_info=""
for mac in $connected_devices; do
    battery=$(echo "info $mac" | bluetoothctl | grep "Battery Percentage" | sed 's/.*(\([0-9]*\)).*/\1/')
    name=$(echo "info $mac" | bluetoothctl | grep "Name" | cut -d: -f2 | xargs)
    
    if [ -n "$battery" ] && [ "$battery" != "(unknown)" ]; then
        battery_info="${battery}%"
        break  # Show first matching headphones
    fi
done

if [ -n "$battery_info" ]; then
    echo " $battery_info"
else
    echo " --%"
fi
