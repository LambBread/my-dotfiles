#!/bin/bash

if protonvpn status | grep -q 'Connected'; then
    echo '%{F#9fd356}%{F-}' 
else
    echo '%{F#f08533}%{F-}'
fi
