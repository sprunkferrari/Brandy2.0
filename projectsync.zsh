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
PRJ_DATE_SPRUNK_MINI=$(date -r $PRJ_PATH)
#retrieve remote date 1
if pingsub $SPRUNKBOOK ; then
    PRJ_DATE_SPRUNKBOOK=$(ssh sprunk@"$SPRUNKBOOK" date -r $PRJ_PATH)
    else PRJ_DATE_SPRUNKBOOK="Not found"
fi
#retrieve remote date 2
if pingsub $JURI_MINI ; then
    PRJ_DATE_JURI_MINI=$(ssh sprunk@"$JURI_MINI" date -r $PRJ_PATH)
    else PRJ_DATE_JURI_MINI="Not found"
fi
#check date matching
printf "--------------\n"
printf "SPRUNK_MINI Project:\t"$PRJ_DATE_SPRUNK_MINI"\n"
printf "JURI_MINI Project:\t"$PRJ_DATE_JURI_MINI"\n"
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
    echo "Choose the sync direction.\n1) From SPRUNKBOOK to the others.\n2) From SPRUNK_MINI to the others.\n3) From JURI_MINI to the others."
    read ANSWER
    case $ANSWER in
        ( 1 )   ssh sprunk@"$SPRUNKBOOK" rsync -avPzh –delete $PRJ_PATH  sprunk@"$SPRUNK_MINI":"$PRJ_PATH"
            && echo "Successful update on SPRUNK_MINI"
            if [ "$PRJ_DATE_JURI_MINI" != "Not found" ] ;
                then ssh sprunk@"$SPRUNKBOOK" rsync -avPzh –delete $PRJ_PATH sprunk@"$JURI_MINI":"$PRJ_PATH"
                && echo "Successful update on JURI_MINI"
            fi;;
        ( 2 )   if [ "$PRJ_DATE_SPRUNKBOOK" != "Not found" ] ;
                    then rsync -avPzh -delete $PRJ_PATH sprunk@"$SPRUNKBOOK":"$PRJ_PATH"
                    && echo "Successful update on SPRUNKBOOK"
                fi
                if [ "$PRJ_DATE_JURI_MINI" != "Not found" ] ;
                    then rsync -avPzh -delete $PRJ_PATH sprunk@"$JURI_MINI":"$PRJ_PATH"
                    && echo "Successful update on JURI_MINI"
                fi ;;
        ( 3 )   ssh sprunk@"$JURI_MINI" rsync -avPzh –delete $PRJ_PATH sprunk@"$SPRUNK_MINI":"$PRJ_PATH"
                if [ "$PRJ_DATE_SPRUNKBOOK" != "Not found" ] ;
                then ssh sprunk@"$JURI_MINI" rsync -avPzh –delete $PRJ_PATH sprunk@"$SPRUNKBOOK":"$PRJ_PATH"
                    && echo "Successful update on JURI_MINI"
                fi;;
    esac
done
    
