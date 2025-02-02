#!/bin/zsh

#  terminate.zsh
#  
#
#  Created by Francesco Ferrari on 20/12/24.
#  
clear
printf "-------------\n"
printf "Ready to Terminate\n"
printf "-------------\n"

. ./definitions.zsh
set - $(printenv RASPI_DEVICES)
printf "Stopping playback\n"
sendosc 127.0.0.1 39051 /global/stop s uuid=aa11
#Quitting local
while ; do
        printf "Quitting SPRUNKMINI... " ;
        ./routines/quit.zsh ;
        if [[ $? == "0" ]] ; then
            printf "\tSuccess\n" && break
            else printf "\tFailed. Try again? y/n ->"
                read ANSWER
                case $ANSWER in
                    ( y ) continue ;;
                    ( n ) break ;;
            esac
        fi
done

if pingsub "$JURIMINI" ; then
	# Quitting J
    while ; do
        printf "Quitting JURIMINI... "
        ssh sprunk@"$JURIMINI" "$BRANDY_PATH"/routines/quit.zsh
        if [ $? = "0" ] ;
            then printf "\tSuccess\n" && break
            else printf "\tFailed. Try again? y/n ->"
                read ANSWER
                case $ANSWER in
                    ( y ) continue ;;
                    ( n ) break ;;
            esac
        fi
    done ;        
    #Shutting J
    while ; do
        printf "Shutting down JURIMINI... "
        ssh sprunk@"$JURIMINI" "$BRANDY_PATH"/routines/shutdown.zsh
        if [ $? = "0" ] ;
            then printf "\tSuccess\n" && break ;
            else printf "\tFailed. Try again? y/n ->" ;
            read ANSWER ;
            case $ANSWER in
                ( y ) continue;;
                ( n ) break;;
            esac
        fi
    done
fi
	
printf "------------\n"
sleep 3
#Shutting remotes
for DEVICE ; do
    eval IP_ADDRESS=$"$DEVICE"
    if pingsub $IP_ADDRESS ; then
        while ; do
        	printf "Shutting down $DEVICE ... "
    		ssh $IP_ADDRESS sudo shutdown -h now &> /dev/null
            if ( [ $? = 255 ] || [ $? = 0 ] ) ;
                then printf "\tSuccess\n" && break
                else printf "\tFailed. Try again? y/n ->"
                read ANSWER
                case $ANSWER in
                    ( y ) continue ;;
                    ( n ) break ;;
                esac
            fi
        done
    fi
done

#Shutting local
printf "Shutting down SPRUNKMINI. Goodbye\n"
sleep 5
"$BRANDY_PATH"/routines/shutdown.zsh
