#!/usr/bin/env bash

# Get battery info
BATT_INFO=$(pmset -g batt)

if echo "$BATT_INFO" | grep -q "charging"; then
    # Actually charging - show adapter wattage
    WATTS=$(ioreg -l -w 0 | grep -o '"Watts"=[0-9]*' | head -1 | sed 's/"Watts"=//')
    [ -z "$WATTS" ] && WATTS=0
    echo "${WATTS}W"
elif echo "$BATT_INFO" | grep -q "AC Power"; then
    # On AC power but not charging (battery full)
    echo "FULL"
else
    # On battery
    echo "BAT"
fi
