#!/bin/zsh
############
# Brandy2.0 by Francesco Ferrari
# Project Sync: a simple tool for automating copy of the Project Folder to multiple destinations
############
printf "----------------\n"
. ./definitions.zsh
printf "---Project Sync----\n-----------------\n"
printf "Checking project date matching...\n"
#retrieve local prj date
PRJ_DATE_SPRUNKMINI=$(date -r $PRJ_PATH)
#retrieve remote date 1
if pingsub $SPRUNKBOOK ; then
    PRJ_DATE_SPRUNKBOOK=$(ssh sprunk@"$SPRUNKBOOK" date -r $PRJ_PATH)
    else PRJ_DATE_SPRUNKBOOK="Not found"
fi
#retrieve remote date 2
if pingsub $JURIMINI ; then
    PRJ_DATE_JURIMINI=$(ssh sprunk@"$JURIMINI" date -r $PRJ_PATH)
    else PRJ_DATE_JURIMINI="Not found"
fi
#check date matching
printf "--------------\n"
printf "SPRUNKMINI Project:\t"$PRJ_DATE_SPRUNKMINI"\n"
printf "JURIMINI Project:\t"$PRJ_DATE_JURIMINI"\n"
printf "SPRUNKBOOK Project:\t"$PRJ_DATE_SPRUNKBOOK"\n"
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
#prompt user for sync direction
while :
do
    echo "Choose the sync direction.\n1) From SPRUNKBOOK to the others.\n2) From SPRUNKMINI to the others.\n3) From JURIMINI to the others."
    read ANSWER
    case $ANSWER in
        ( 1 )   ssh sprunk@"$SPRUNKBOOK" rsync -avPzh –delete $PRJ_PATH  sprunk@"$SPRUNKMINI":"$BRANDY_PATH" && echo "Successful update on SPRUNKMINI"; [ "$PRJ_DATE_JURIMINI" != "Not found" ] && ssh sprunk@"$SPRUNKBOOK" rsync -avPzh –delete $PRJ_PATH sprunk@"$JURIMINI":"$BRANDY_PATH" && echo "Successful update on JURIMINI";;
        ( 2 )   [ "$PRJ_DATE_SPRUNKBOOK" != "Not found" ] && rsync -avPzh -delete $PRJ_PATH sprunk@"$SPRUNKBOOK":"$BRANDY_PATH" && echo "Successful update on SPRUNKBOOK"; [ "$PRJ_DATE_JURIMINI" != "Not found" ] && rsync -avPzh -delete $PRJ_PATH sprunk@"$JURIMINI":"$BRANDY_PATH" && echo "Successful update on JURIMINI";;
        ( 3 )   [ "$PRJ_DATE_JURIMINI" != "Not found" ] && ssh sprunk@"$JURIMINI" rsync -avPzh –delete $PRJ_PATH sprunk@"$SPRUNKMINI":"$BRANDY_PATH" && echo "Successful update on SPRUNKMINI"; [ "$PRJ_DATE_SPRUNKBOOK" != "Not found" ] && ssh sprunk@"$JURIMINI" rsync -avPzh –delete $PRJ_PATH sprunk@"$SPRUNKBOOK":"$BRANDY_PATH" && echo "Successful update on JURIMINI";;
    esac
done
    
