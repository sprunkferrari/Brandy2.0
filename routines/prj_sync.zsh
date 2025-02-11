ssh $1 rsync -azh --delete $PRJ_PATH/ $2:$PRJ_PATH/
