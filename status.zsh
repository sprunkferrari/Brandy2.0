#!/bin/zsh
#
# Script for checking and displaying the status of the system.
# If all devices are running, the exit status is 0.
#
#############
LOGFILE="./log.txt"
echo "-----------------"
echo "Performing network checkup."
. ./definitions.zsh
echo "-----------------"
set - $(printenv ALL_DEVICES)
COUNT_MISSING="0"
COUNT_CONNECTED="0"

for DEVICE ; do
    eval IP_ADDRESS=$"$DEVICE"
    if ! ping -o -c 3 -t 2 $IP_ADDRESS > /dev/null ; then
        echo "$DEVICE is missing."
        COUNT_MISSING=$(("$COUNT_MISSING" + 1))
        else COUNT_CONNECTED=$(expr "$COUNT_CONNECTED" '+' '1')
    fi
done

echo "-----------------"
echo ""$COUNT_CONNECTED"/"$#" devices connected"
if [[ COUNT_MISSING > 0 ]]; then
    echo "$COUNT_MISSING devices missing"

fi
echo "-----------------"
echo "Performing DANTE checkup."
echo "-----------------"
dante-cli list-devices
