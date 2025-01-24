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
printf "Quitting local..."
shortcuts Quit
if [[ $? == 0 ]] ; 
then printf "\tSuccess\n"
else	while [[ $? == 1 ]]; do
			printf "\nFailed. Try again? y/n ->"
            read ANSWER
            case $ANSWER in
            	( y ) continue;;
                ( n ) break;;
                ( * ) printf "Not allowed.\n" && continue;;
            esac
        done
#Quitting J
if pingsub "$JURI_MINI" ; then
    printf "Quitting JURI_MINI..."
    ssh sprunk@"$(printenv JURI_MINI)" shortcuts Quit
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
