#!/bin/zsh

#  terminate.zsh
#  
#
#  Created by Francesco Ferrari on 20/12/24.
#
printf "-------------\n"
printf "Quit tool\n"
printf "-------------\n"

. ./definitions.zsh
printf "Stopping playback\n"
sendosc 127.0.0.1 39051 /global/stop s uuid=aa11
notifysub "Playback stopped" "By Quit script"
#Quitting local
while ; do
        printf "Quitting SPRUNKMINI... " ;
        ./routines/quit.zsh ;
        if [[ $? == "0" ]] ; then
            printf "\tSuccess\n" && notifysub "Quit SPRUNKMINI" "Quit Seq. 1/2" && break
            else printf "\tFailed. Try again? y/n ->" && notifysub "SprMini Quit FAILED" "QuitSeq Halted" ;
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
        ssh $JURIMINI "$BRANDY_PATH"/routines/quit.zsh
        if [ $? = "0" ] ;
            then printf "\tSuccess\n" && notifysub "Quit JURIMINI" "Term Seq. 2/2" && break
            else printf "\tFailed. Try again? y/n ->" && "JurMini Quit FAILED" "QuitSeq Halted" ;
                read ANSWER
                case $ANSWER in
                    ( y ) continue ;;
                    ( n ) break ;;
            esac
        fi
    done
fi

