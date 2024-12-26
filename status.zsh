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
        else COUNT_CONNECTED=$(expr "$COUNT_CONNECTED" '+' '1')
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
printf "Performing USB (VirtualHere) checkup"
printf "\n"
$VIRTUALHERE_PATH -t list

sleep 1
printf "-----------------\n"
printf "Performing DANTE checkup.\n"
printf "\n"
DANTE_LIST=$(dante-cli list-devices)

printf "--DEVICE------NET STATUS------VH STATUS--------DANTE STATUS--\n"
for DEVICE ; do
if  $DANTE_LIST | grep $DEVICE ; then
        export ""$DEVICE"_DN_STATUS"="CONNECTED"
        else export ""$DEVICE"_DN_STATUS"="MISSING"
    printf "$DEVICE     $(eval "$DEVICE"_STATUS)    "$(eval "$DEVICE"_VH_STATUS)     $(eval "$DEVICE"_DN_STATUS)"

