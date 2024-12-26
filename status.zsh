#!/bin/zsh
#
# Script for checking and displaying the status of the system.
# If all devices are running, the exit status is 0.
#
#############
LOGFILE="./log.txt"
printf "-----------------\n"
printf "Performing network checkup.\n"
. ./definitions.zsh
printf "\n"
set - $(printenv ALL_DEVICES)
COUNT_MISSING="0"
COUNT_CONNECTED="0"

for DEVICE ; do
    eval IP_ADDRESS=$"$DEVICE"
    if ! ping -o -c 3 -t 2 $IP_ADDRESS > /dev/null ; then
        printf "$DEVICE is missing. "
        COUNT_MISSING=$(("$COUNT_MISSING" + 1))
        export ""$DEVICE"_STATUS"="MISSING"
        else COUNT_CONNECTED=$(("$COUNT_CONNECTED" + 1))
        export ""$DEVICE"_STATUS"="CONNECTED"
    fi
done

printf "\n"
printf ""$COUNT_CONNECTED"/"$#" devices connected\n"
if [[ COUNT_MISSING > 0 ]]; then
    printf "$COUNT_MISSING devices missing\n"

fi

sleep 1
printf "-----------------\n"
printf "Performing USB (VirtualHere) checkup.\n"
VH_LIST=$($VIRTUALHERE_PATH -t list)

sleep 1
printf "-----------------\n"
printf "Performing DANTE checkup.\n"
DN_LIST=$(dante-cli list-devices)

printf "--DEVICE------NET STATUS------VH STATUS-------DANTE STATUS--\n"
for DEVICE ; do
if  [[ $DEVICE =~ $DN_LIST ]] ; then
        export ""$DEVICE"_DN_STATUS"="CONNECTED"
        else export ""$DEVICE"_DN_STATUS"="MISSING"
fi
if  [[ $DEVICE =~ $VH_LIST ]] ; then
        export ""$DEVICE"_VH_STATUS"="CONNECTED"
        else export ""$DEVICE"_VH_STATUS"="MISSING"
fi
    printf "$DEVICE     $(printenv "$DEVICE"_STATUS)    "$(printenv "$DEVICE"_VH_STATUS)     $(printenv "$DEVICE"_DN_STATUS)"

