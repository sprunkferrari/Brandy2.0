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
                ./routines/launch_malvax.zsh && echo "Project opened on SPRUNKMINI";
                if [[ "$JURIMINI_STATUS" != "\e[1;32mCONNECTED\e[m" ]] ;
                    then printf "WARNING: JURIMINI is missing. ENTER to continue anyway." && read CONTINUE
                    else gtimeout 2 ssh $JURIMINI shortcuts run "Nascondi\ app" ;
                    ssh sprunk@"$JURIMINI" Brandy2.0/routines/launch_malvax_B.zsh && echo "Project opened on JURIMINI";
                fi ;
                printf "Done. Have fun!" && exit 0 ;;
            ( malvax_xf )
                printf "--- Launching Malvax for winning X Factor! ---\n" ;
                export ACTIVE_PROJECT="malvax" ;
                shortcuts run "Nascondi app" ;
                ./routines/launch_malvax_xf.zsh ;
                if [[ "$JURIMINI_STATUS" != "\e[1;32mCONNECTED\e[m" ]] ;
                    then printf "WARNING: JURIMINI is missing. ENTER to continue anyway." && read CONTINUE
                    else gtimeout 2 ssh $JURIMINI shortcuts run "Nascondi\ app" ;
                    ssh sprunk@"$JURIMINI" Brandy2.0/routines/launch_malvax_xf.zsh ;
                fi ;
                printf "Done. Have fun!" && exit 0 ;;
            ( lpm )
                printf "--- Launching LPM ---" ;
                export ACTIVE_PROJECT="lpm" ;
                ssh sprunk@"$SPRUNKMINI" ./launch_lpm.zsh ;
                exit 0 ;;
            ( lpm_afterdark )
                printf "--- Launching LPM Afterdark ---" ;
                shortcuts run "Nascondi app" ;
                ./routines/launch_lpm_afterdark.zsh ;
                export ACTIVE_PROJECT="lpm_afterdark" ;
                printf "Done. Lory Gay!" && exit 0 ;;
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
