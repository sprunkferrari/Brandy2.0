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
set - $(printenv RASPI_DEVICES)

#Quitting local
printf "Quitting local..."
shortcuts run Quit
if [[ $? == 0 ]] ;
then printf "\tSuccess\n"
else	while [[ $? == 1 ]]; do
			printf "\nFailed. Try again? y/n ->"
            read ANSWER
            case $ANSWER in
            	( y ) printf "Quitting local..." && shortcuts run Quit ;;
                ( n ) break;;
                ( * ) printf "Not allowed.\n" && continue;;
            esac
        done
fi


if pingsub "$JURI_MINI" ; then
	# Quitting J
    printf "Quitting JURI_MINI..."
    ssh sprunk@"$(printenv JURI_MINI)" shortcuts run Quit
    if [[ $? == 0 ]] ; 
		then printf "\tSuccess\n"
		else	while [[ $? == 1 ]]; do
					printf "\nFailed. Try again? y/n ->"
            		read ANSWER
            		case $ANSWER in
            		( y ) printf "Quitting JURI_MINI..." && ssh sprunk@"$(printenv JURI_MINI)" shortcuts run Quit ;;
                ( n ) break ;;
                ( * ) printf "Not allowed.\n" && continue ;;
            	esac
        		done
	fi
        
        #Shutting J
        printf "Shutting down JURI_MINI..."
        ssh sprunk@"$(printenv JURI_MINI)" osascript -e 'tell app "System Events" to shut down'
        if [[ $? == 0 ]] ; 
then printf "\tSuccess\n"
else	while [[ $? == 1 ]]; do
			printf "\nFailed. Try again? y/n ->"
            read ANSWER
            case $ANSWER in
            	( y ) printf "Shutting down JURI_MINI..." && ssh sprunk@"$(printenv JURI_MINI)" osascript -e 'tell app "System Events" to shut down' ;;
                ( n ) break ;;
                ( * ) printf "Not allowed.\n" && continue ;;
            esac
        done
fi
	
        
fi
printf "------------\n"
sleep 3
#Shutting remotes
for DEVICE ; do
        eval IP_ADDRESS=$"$DEVICE"
        if pingsub $IP_ADDRESS ; then
        	printf "Shutting down $DEVICE ..."
    		ssh sprunk@"$IP_ADDRESS" shutdown -h now
        		if [[ $? == 0 ]] ; 
					then printf "\tSuccess\n"
					else	while [[ $? == 1 ]]; do
								printf "\nFailed. Try again? y/n ->"
            					read ANSWER
            				case $ANSWER in
            					( y ) printf "Shutting down $DEVICE ..." && ssh sprunk@"$IP_ADDRESS" shutdown -h now ;;
                ( n ) break;;
                ( * ) printf "Not allowed.\n" && continue;;
            				esac
        					done
                fi
        fi
done

#Shutting local
printf "Shutting down local. Goodbye\n"
sleep 5
osascript -e 'tell app "System Events" to shut down'
