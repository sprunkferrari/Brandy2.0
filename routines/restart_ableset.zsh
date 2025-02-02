#!/bin/zsh

#  terminate.zsh
#  
#
#  Created by Francesco Ferrari on 20/12/24.
#
osascript -e 'tell app "AbleSet" to if it is running then quit' &> /dev/null
sleep 5
osascript -e 'tell app "AbleSet" to activate'
