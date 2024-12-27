#!/bin/zsh

#  launcher.zsh
#  
#
#  Created by Francesco Ferrari on 20/12/24.
#
clear
printf "--- BRANDY 2.0 --\n"
printf "-----------------\nWelcome Sprunk!\n-----------------\n"

. ./status.zsh
if [[ $? = 1 ]] ; then
 while :
            do
                printf "WARNING: Not all devices are connected. Continue anyway? y/n -> "
                read CONTINUE
                case $CONTINUE in
                    ( y ) break;;
                    ( n ) exit 1 ;;
                    ( * ) printf "Not allowed\n" && continue ;;
                esac
            done
fi

printf "--------------\n"
printf "Now Launching"
printf "--------------\n"

if [[ "$SPRUNK_MINI_STATUS" != "CONNECTED" ]];
    then while :
            do
                printf "WARNING: SPRUNK_MINI is missing. Continue anyway? y/n -> "
                read CONTINUE
                case $CONTINUE in
                    ( y ) break;;
                    ( n ) exit 1 ;;
                    ( * ) printf "Not allowed\n" && continue ;;
                esac
            done
fi

while :
do
    printf "Enter the name of the project you wish to boot (default: malvax) -> "
    read -t 5 PROJECT_NAME
    case $PROJECT_NAME in
        ( malvax | "" )
            if [[ "$JURI_MINI_STATUS" != "CONNECTED" ]];
                then  while :
                        do
                            printf "WARNING: JURI_MINI is missing. Continue anyway? y/n -> "
                            read CONTINUE
                            case $CONTINUE in
                                ( y ) break;;
                                ( n ) exit 1 ;;
                                ( * ) printf "Not allowed\n" && continue ;;
                            esac
                        done
            fi
            break
            printf "--- Launching Malvax ---"
            export ACTIVE_PROJECT="MALVAX"
            ssh sprunk@"$SPRUNK_MINI" ./launch_malvax.zsh &&
            ssh sprunk@"$JURI_MINI" ./launch_malvax_seq.zsh
            ;;
        ( lpm )
            break
            printf "--- Launching LPM ---"
            export ACTIVE_PROJECT="LPM"
            ssh sprunk@"$SPRUNK_MINI" ./launch_lpm.zsh ;;
        ( bper )
            break
            printf "--- Launching BPER ---"
            export ACTIVE_PROJECT="BPER"
            ssh sprunk@"$SPRUNK_MINI" ./launch_bper.zsh ;;
        ( * ) printf "ERROR: Project not found.\n" && continue ;;
    esac
done


