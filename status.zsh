#!/bin/zsh
#
# Script for checking and displaying the status of the system.
# If all devices are running, the exit status is 0.
#
#############
LOGFILE="./log.txt"
printf "-----------------\nPerforming network checkup.\n-----------------\n"

. ./definitions.zsh
set - $(printenv ALL_DEVICES)
COUNT_MISSING="0"
COUNT_CONNECTED="0"

pingsub()
{
    local IP_ADDRESS
    eval IP_ADDRESS=$"$1"
    ping -o -c 3 -t 2 -q $IP_ADDRESS &> /dev/null
}

sleep 1
printf "Performing VH checkup...\n"
$VIRTUALHERE_PATH -t list 2> ./temp/vh_list

sleep 1
printf "Performing DANTE checkup...\n"
dante-cli list-devices > ./temp/dn_list

printf "\n--DEVICE--\t\t-NET STATUS-\t\t-VH STATUS-\t\t-DANTE STATUS-\n\n"
for DEVICE ; do
    if pingsub $DEVICE > /dev/null ;
        then
            COUNT_CONNECTED=$(("$COUNT_CONNECTED" + 1))
            export ""$DEVICE"_STATUS"="CONNECTED"
        else COUNT_MISSING=$(("$COUNT_MISSING" + 1))
            export ""$DEVICE"_STATUS"="MISSING"
    fi
    if  grep -q $DEVICE ./temp/vh_list ;
        then export ""$DEVICE"_VH_STATUS"="CONNECTED"
        else export ""$DEVICE"_VH_STATUS"=""
    fi
    if  grep -q $DEVICE ./temp/dn_list ; then
        export ""$DEVICE"_DN_STATUS"="CONNECTED"
        else export ""$DEVICE"_DN_STATUS"=""
    fi
    printf "$DEVICE\t\t$(printenv "$DEVICE"_STATUS)\t\t$(printenv "$DEVICE"_VH_STATUS)\t\t$(printenv "$DEVICE"_DN_STATUS)\n\n"
done
printf "\n"
printf ""$COUNT_CONNECTED"/"$#" devices connected\n"
if [[ COUNT_MISSING > 0 ]]; then
    printf "WARNING: $COUNT_MISSING devices missing\n" && exit 1
    else exit 0
fi
