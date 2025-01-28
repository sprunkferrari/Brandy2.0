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

if [[ "$SPRUNKMINI_STATUS" != "\e[1;32mCONNECTED\e[m" ]];
    then
                printf "WARNING: SPRUNKMINI is missing. ENTER to continue anyway."
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
            if [[ "$JURIMINI_STATUS" != "\e[1;32mCONNECTED\e[m" ]];
                then
                            printf "WARNING: JURIMINI is missing. ENTER to continue anyway."
                            read CONTINUE
            fi
            break
            printf "--- Launching Malvax ---"
            export ACTIVE_PROJECT="malvax"
            ssh sprunk@"$SPRUNKMINI" ./launch_malvax.zsh &&
            ssh sprunk@"$JURIMINI" ./launch_malvax_seq.zsh
            ;;
        ( lpm )
            break
            printf "--- Launching LPM ---"
            export ACTIVE_PROJECT="lpm"
            ssh sprunk@"$SPRUNKMINI" ./launch_lpm.zsh ;;
        ( bper )
            break
            printf "--- Launching BPER ---"
            export ACTIVE_PROJECT="bper"
            ssh sprunk@"$SPRUNKMINI" ./launch_bper.zsh ;;
        ( * ) printf "ERROR: Project not found.\n" && continue ;;
    esac
done


