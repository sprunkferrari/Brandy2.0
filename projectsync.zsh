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
    PRJ_DATE_SPRUNKBOOK=$(ssh $SPRUNKBOOK date -r $PRJ_PATH)
    else PRJ_DATE_SPRUNKBOOK="Not found"
fi
#retrieve remote date 2
if pingsub $JURIMINI ; then
    PRJ_DATE_JURIMINI=$(ssh $JURIMINI date -r $PRJ_PATH)
    else PRJ_DATE_JURIMINI="Not found"
fi
#check date matching
printf "--------------\n"
printf "SPRUNKMINI Project:\t"$PRJ_DATE_SPRUNKMINI"\n"
printf "JURIMINI Project:\t"$PRJ_DATE_JURIMINI"\n"
printf "SPRUNKBOOK Project:\t"$PRJ_DATE_SPRUNKBOOK"\n"
#prompt user for syncing
while ; do
        printf "Do you wish to sync? y/n ->"
        read ANSWER
        case $ANSWER in
        ( y ) break ;;
        ( n ) exit ;;
        ( * ) printf "Not allowed. Try again.\n" && continue ;;
        esac
done
#prompt user for sync direction
while ; do
    echo "Choose the sync direction.\n1) From SPRUNKBOOK to the others.\n2) From SPRUNKMINI to the others.\n3) From JURIMINI to the others."
    read ANSWER
    case $ANSWER in
        ( 1 ) syncsub $SPRUNKBOOK $SPRUNKMINI && echo "Successful update on SPRUNKMINI";
            [ "$PRJ_DATE_JURIMINI" != "Not found" ] && syncsub $SPRUNKBOOK $JURIMINI && echo "Successful update on JURIMINI" ;
            exit ;;
        ( 2 ) [ "$PRJ_DATE_SPRUNKBOOK" != "Not found" ] && syncsub $SPRUNKMINI $SPRUNKBOOK && echo "Successful update on SPRUNKBOOK";
            [ "$PRJ_DATE_JURIMINI" != "Not found" ] && syncsub $SPRUNKMINI $JURIMINI && echo "Successful update on JURIMINI";
            exit ;;
        ( 3 ) syncsub $JURIMINI $SPRUNKMINI && echo "Successful update on SPRUNKMINI";
            [ "$PRJ_DATE_SPRUNKBOOK" != "Not found" ] && syncsub $JURIMINI $SPRUNKBOOK && echo "Successful update on SPRUNKBOOK";
            exit ;;
    esac
done
    
