#!/bin/zsh

#  launcher.zsh
#  
#
#  Created by Francesco Ferrari on 20/12/24.
#
clear
printf "--- BRANDY 2.0 --\n"
printf "-----------------\nWelcome Sprunk!\n-----------------\n"

. ./netstatus.zsh
if [[ $? = 1 ]] ; then
            printf "WARNING: Not all devices are connected. ENTER to continue anyway."
            read CONTINUE
fi

printf "--------------\n"
printf "Now Launching"
printf "--------------\n"

if [[ "$SPRUNK_MINI_STATUS" != "CONNECTED" ]];
    then
                printf "WARNING: SPRUNK_MINI is missing. ENTER to continue anyway."
                read CONTINUE
fi

while :
do
if [[ $ACTIVE_PROJECT == "" ]]; then

    printf "Enter the name of the project you wish to boot (default: malvax) -> "
    read -t 5 PROJECT_NAME
else PROJECT_NAME=$ACTIVE_PROJECT
fi
    case $PROJECT_NAME in
        ( malvax | "" )
            if [[ "$JURI_MINI_STATUS" != "CONNECTED" ]];
                then
                            printf "WARNING: JURI_MINI is missing. ENTER to continue anyway."
                            read CONTINUE
            fi
            break
            printf "--- Launching Malvax ---"
            export ACTIVE_PROJECT="malvax"
            ssh sprunk@"$SPRUNK_MINI" ./launch_malvax.zsh &&
            ssh sprunk@"$JURI_MINI" ./launch_malvax_seq.zsh
            ;;
        ( lpm )
            break
            printf "--- Launching LPM ---"
            export ACTIVE_PROJECT="lpm"
            ssh sprunk@"$SPRUNK_MINI" ./launch_lpm.zsh ;;
        ( bper )
            break
            printf "--- Launching BPER ---"
            export ACTIVE_PROJECT="bper"
            ssh sprunk@"$SPRUNK_MINI" ./launch_bper.zsh ;;
        ( * ) printf "ERROR: Project not found.\n" && continue ;;
    esac
done


