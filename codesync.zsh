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
if pingsub $SPRUNK_MINI ; then
    BRANDY_DATE_SPRUNK_MINI=$(ssh sprunk@"$SPRUNK_MINI" date -r $BRANDY_PATH)
    else BRANDY_DATE_SPRUNK_MINI="Not found"
fi
#retrieve remote date 2
if pingsub $JURI_MINI ; then
    BRANDY_DATE_JURI_MINI=$(ssh sprunk@"$JURI_MINI" date -r $BRANDY_PATH)
    else BRANDY_DATE_JURI_MINI="Not found"
fi
#check date matching
printf "--------------\n"
printf "SPRUNKBOOK Project:\t"$BRANDY_DATE_SPRUNKBOOK"\n"
printf "SPRUNK_MINI Project:\t"$BRANDY_DATE_SPRUNK_MINI"\n"
printf "JURI_MINI Project:\t"$BRANDY_DATE_JURI_MINI"\n"
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
rsync -avPzh –delete $BRANDY_PATH sprunk@"$SPRUNK_MINI":"$BRANDY_PATH" && echo "Successful update on SPRUNK_MINI"
[ "$BRANDY_DATE_JURI_MINI" != "Not found" ] && rsync -avPzh –delete $BRANDY_PATH sprunk@"$JURI_MINI":"$BRANDY_PATH" && echo "Successful update on JURI_MINI"
exit
