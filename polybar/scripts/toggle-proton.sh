#!/bin/bash

if protonvpn status | grep -q 'Connected'; then
    protonvpn disconnect
else
    protonvpn connect
fi
