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
if pingsub 192.168.1.11 ; then
    printf "Quitting JURI_MINI\n"
    ssh sprunk@192.168.1.11 ./quit.zsh
fi

#Shutting remotes
for DEVICE ; do
        eval IP_ADDRESS=$"$DEVICE"
        if pingsub $IP_ADDRESS ; then
        printf "Shutting down $DEVICE\n"
        ssh sprunk@"$IP_ADDRESS" shutdown -h now
        fi
done

#Shutting local
printf "Shutting down local...\n"
shutdown -h 5
