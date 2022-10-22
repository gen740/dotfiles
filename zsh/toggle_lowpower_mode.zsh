#!/bin/zsh

lowpower_mode=`pmset -g | sed -n -e /lowpowermode/p | sed -e "s/ *lowpowermode *\([0-1]\)/\1/g"`
echo $lowpower_mode

if [[ $lowpower_mode == "1" ]]; then
    osascript -e 'display notification "Low Power Mode is OFF" with title "Notification"'
    pmset -a lowpowermode 0
else;
    osascript -e 'display notification "Low Power Mode is ON" with title "Notification"'
    pmset -a lowpowermode 1
fi
