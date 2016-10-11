#!/bin/bash
#### Description: Review battery status and notify when
#### battery is totally loaded or it is minus MIN_PERCENTAGE
#### Written by: Ludim Sanchez - ludim.anel@gmail.com on Oct-2016

MIN_PERCENTAGE=30
MAX_PERCENTAGE=100

## Get battery status
BATTERY_STATUS=$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage" | awk {'print $2'} | sed 's/.$//g')
BATTERY_STATUS=$(($BATTERY_STATUS+0))
echo $BATTERY_STATUS
echo $MIN_PERCENTAGE
echo $MAX_PERCENTAGE

## Check if the battery status
## BATTERY_STATUS < MIN_PERCENTAGE
if [ "$BATTERY_STATUS" -eq "$MIN_PERCENTAGE" 2>/dev/null ]; then
    echo "$BATTERY_STATUS < $MIN_PERCENTAGE ";
    echo 'Tal vez debes ponerme a cargar'
    notify-send 'Tal vez debes ponerme a cargar';
fi 

## BATTERY_STATUS > MAX_PERCENTAGE
if [ "$BATTERY_STATUS" -ge "$MAX_PERCENTAGE" 2>/dev/null ]; then
    echo "$BATTERY_STATUS > $MAX_PERCENTAGE "
    echo 'Desconecta la bateria'
    notify-send 'Desconecta la bateria';
fi