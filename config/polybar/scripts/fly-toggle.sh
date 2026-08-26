#!/bin/bash
if pgrep -f 'polybar fly'; then
    pkill -f 'polybar fly'
else
    polybar fly & 
fi
