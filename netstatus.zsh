#!/bin/zsh
#
# Script for checking and displaying the status of the system.
# If all devices are running, the exit status is 0.
#
#############
LOGFILE="./log.txt"
printf "-----------------\nPerforming Network / VH / Dante checkup...\n\n"

. ./definitions.zsh
set - $(printenv ALL_DEVICES)
COUNT_MISSING="0"
COUNT_CONNECTED="0"

$VIRTUALHERE_PATH -t list 2> ./temp/vh_list

sleep 1
dante-cli list-devices > ./temp/dn_list
sleep 1
printf "\n--DEVICE--\t\t-NET STATUS-\t-VH STATUS-\t-DANTE STATUS-\n\n"
for DEVICE ; do
    IP_ADDRESS=$(printenv $DEVICE)
    if pingsub $IP_ADDRESS ;
        then
            COUNT_CONNECTED=$(("$COUNT_CONNECTED" + 1))
            export ""$DEVICE"_STATUS"="\e[1;32mCONNECTED\e[m"
        else COUNT_MISSING=$(("$COUNT_MISSING" + 1))
            export ""$DEVICE"_STATUS"="MISSING"
    fi ;
    if  grep -q $DEVICE ./temp/vh_list ;
        then export ""$DEVICE"_VH_STATUS"="\e[1;32mCONNECTED\e[m"
        else export ""$DEVICE"_VH_STATUS"=""
    fi ;
    if  grep -q $DEVICE ./temp/dn_list ; then
        export ""$DEVICE"_DN_STATUS"="\e[1;32mCONNECTED\e[m"
        else export ""$DEVICE"_DN_STATUS"=""
    fi ;
    printf "$DEVICE\t\t$(printenv "$DEVICE"_STATUS)\t$(printenv "$DEVICE"_VH_STATUS)\t$(printenv "$DEVICE"_DN_STATUS)\n\n"
done
printf "\n"$COUNT_CONNECTED"/"$#" devices connected\n"
if [[ $COUNT_MISSING > 0 ]]; then
    printf "WARNING: $COUNT_MISSING devices missing\n" && return 1
    else return 0

fi
