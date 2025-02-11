#!/bin/zsh

#  terminate.zsh
#  
#
#  Created by Francesco Ferrari on 20/12/24.
#
osascript -e 'tell app "Ableton Live 12 Suite" to if it is running then activate' &> /dev/null
sleep 1
osascript -e 'tell app "System Events" to keystroke "s" using command down'
sleep 3
osascript -e 'tell app "Ableton Live 12 Suite" to quit'
sleep 5
