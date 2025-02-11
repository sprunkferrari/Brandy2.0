#!/bin/zsh
############
# Brandy2.0 by Francesco Ferrari
# Project Sync: a simple tool for automating copy of the whole code to multiple destinations
############
printf "----------------\n"
. ./definitions.zsh
printf "---Code Sync----\n-----------------\n"
printf "Checking main folder date matching...\n"
#retrieve local BRANDY date
BRANDY_DATE_SPRUNKBOOK=$(date -r $BRANDY_PATH)
#retrieve remote date 1
if pingsub $SPRUNKMINI ; then
    BRANDY_DATE_SPRUNKMINI=$(ssh sprunk@"$SPRUNKMINI" date -r $BRANDY_PATH)
    else BRANDY_DATE_SPRUNKMINI="Not found"
fi
#retrieve remote date 2
if pingsub $JURIMINI ; then
    BRANDY_DATE_JURIMINI=$(ssh sprunk@"$JURIMINI" date -r $BRANDY_PATH)
    else BRANDY_DATE_JURIMINI="Not found"
fi
#check date matching
printf "--------------\n"
printf "SPRUNKBOOK Project:\t"$BRANDY_DATE_SPRUNKBOOK"\n"
printf "SPRUNKMINI Project:\t"$BRANDY_DATE_SPRUNKMINI"\n"
printf "JURIMINI Project:\t"$BRANDY_DATE_JURIMINI"\n"
#prompt user for syncing
while :
do
        printf "Do you wish to sync? y/n ->"
        read ANSWER
        case $ANSWER in
        ( y ) break ;;
        ( n ) exit ;;
        ( * ) printf "Not allowed. Try again.\n" && continue ;;
        esac
done
./routines/code_sync.zsh $SPRUNKMINI && echo "Successful update on SPRUNKMINI"
[ "$BRANDY_DATE_JURIMINI" != "Not found" ] && ./routines/code_sync.zsh $JURIMINI && echo "Successful update on JURIMINI"
exit
