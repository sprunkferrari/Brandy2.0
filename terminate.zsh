#!/bin/zsh

#  terminate.zsh
#  
#
#  Created by Francesco Ferrari on 20/12/24.
#  
printf "-------------\n"
printf "Ready to Terminate\n"
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
#Shutting remotes
for DEVICE ; do
        eval IP_ADDRESS=$"$DEVICE"
        if pingsub $IP_ADDRESS ; then
        ssh sprunk@"$IP_ADDRESS" shutdown -h now
        printf "Shutting down $DEVICE\n"
        fi
done

#Shutting local
printf "Shutting down local...\n"
shutdown -h 5
