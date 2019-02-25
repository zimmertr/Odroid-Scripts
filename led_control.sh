#!/bin/bash

PREVIOUS_CPU_USAGE=0
PREVIOUS_CPU_IDLE=0

while true; do
    CPU_AGGREGATE=(`sed -n 's/^cpu\s//p' /proc/stat`)
    CPU_IDLE=${CPU_AGGREGATE[3]} 

    CPU_COMBINED_TOTAL=0
    for METRIC in "${CPU_AGGREGATE[@]}"; do
        let "CPU_COMBINED_TOTAL=$CPU_COMBINED_TOTAL+$METRIC"
    done

    let "IDLE_DIFF=$CPU_IDLE-$PREVIOUS_CPU_IDLE"
    let "TOTAL_DIFF=$CPU_COMBINED_TOTAL-$PREVIOUS_CPU_USAGE"
    let "USAGE_DIFF=(1000*($TOTAL_DIFF-$IDLE_DIFF)/$TOTAL_DIFF+5)/10"

    PREVIOUS_CPU_USAGE="$CPU_COMBINED_TOTAL"
    PREVIOUS_CPU_IDLE="$CPU_IDLE"

    if [[ $USAGE_DIFF -gt 5 ]]; then
            echo default-on > /sys/class/leds/blue\:heartbeat/trigger
    else
            echo none > /sys/class/leds/blue\:heartbeat/trigger
    fi

    sleep .05
done
