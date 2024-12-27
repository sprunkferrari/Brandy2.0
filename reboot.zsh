#!/bin/zsh

#  terminate+reboot.zsh
#  
#
#  Created by Francesco Ferrari on 20/12/24.
#  
printf "-------------\n"
printf "Ready to Terminate and Reboot\n"
printf "-------------\n"

. ./definitions.zsh
set - $(printenv PC_DEVICES)

#Quitting local

zsh ./quit.zsh

#Quitting J
if pingsub "$JURI_MINI" ; then
    printf "Quitting JURI_MINI\n"
    ssh sprunk@"$(printenv JURI_MINI)" ./quit.zsh
fi

sleep 5
#Reboot remotes
for DEVICE ; do
        eval IP_ADDRESS=$"$DEVICE"
        if pingsub $IP_ADDRESS ; then
        printf "Rebooting $DEVICE\n"
        ssh sprunk@"$IP_ADDRESS" shutdown -r now
        fi
done

#Reboot local
printf "Rebooting local...\n"
shutdown -r 5
