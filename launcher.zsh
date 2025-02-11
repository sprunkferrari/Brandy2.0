#!/bin/zsh

#  launcher.zsh
#  
#
#  Created by Francesco Ferrari on 20/12/24.
#
clear
printf "--- BRANDY 2.0 --\n"
printf "-----------------\nWelcome Sprunk!\n-----------------\n"
if [ $1 != "" ] ; then export "PROJECT_NAME"="$1"
    elif ( [ $1 = "" ] && [ $ACTIVE_PROJECT != "" ] ) ;
    then export "PROJECT_NAME"=$ACTIVE_PROJECT
fi
. ./netstatus.zsh
[[ $? = 1 ]] && printf "WARNING: Not all devices are connected. ENTER to continue anyway." && read CONTINUE

printf "--------------\nNow Launching\n--------------\n"
while ; do
    case $PROJECT_NAME in
            ( malvax )
                printf "--- Launching Malvax ---\n" ;
                export ACTIVE_PROJECT="malvax" ;
                shortcuts run "Nascondi app" ;
                ./routines/date+dvs.zsh && sleep 1
                ./routines/launch_malvax_A.zsh && echo "Project opened on SPRUNKMINI";
                if [[ "$JURIMINI_STATUS" != "\e[1;32mCONNECTED\e[m" ]] ;
                    then printf "WARNING: JURIMINI is missing. ENTER to continue anyway." && read CONTINUE
                    else gtimeout 2 ssh $JURIMINI shortcuts run "Nascondi\ app" ;
                    ssh sprunk@"$JURIMINI" Brandy2.0/routines/launch_malvax_B.zsh && echo "Project opened on JURIMINI";
                fi ;
                printf "Done. Have fun!" && exit 0 ;;
            ( malvaxtest )
                printf "--- Launching Malvax for testing purposes ---\n" ;
                export ACTIVE_PROJECT="malvax" ;
                shortcuts run "Nascondi app" ;
                ./routines/launch_malvax_test.zsh ;
                if [[ "$JURIMINI_STATUS" != "\e[1;32mCONNECTED\e[m" ]] ;
                    then printf "WARNING: JURIMINI is missing. ENTER to continue anyway." && read CONTINUE
                    else gtimeout 2 ssh $JURIMINI shortcuts run "Nascondi\ app" ;
                    ssh sprunk@"$JURIMINI" Brandy2.0/routines/launch_malvax_test.zsh ;
                fi ;
                printf "Done. Have fun!" && exit 0 ;;
            ( lpm )
                printf "--- Launching LPM ---" ;
                export ACTIVE_PROJECT="lpm" ;
                ssh sprunk@"$SPRUNKMINI" ./launch_lpm.zsh ;
                exit 0 ;;
            ( bper )
                printf "--- Launching BPER ---" ;
                export ACTIVE_PROJECT="bper" ;
                ssh sprunk@"$SPRUNKMINI" ./launch_bper.zsh ;
                exit 0 ;;
            ( "" ) printf "Enter the name of the project you wish to boot ->"
                read PROJECT_NAME && continue ;;
            ( * ) printf "ERROR: Project not found.\n" && unset PROJECT_NAME && continue ;;
    esac
    
done
