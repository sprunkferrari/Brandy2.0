#!/bin/zsh

#  terminate.zsh
#  
#
#  Created by Francesco Ferrari on 20/12/24.
#
osascript -e 'tell app "Ableton Live 12 Suite" to activate'
sleep 1
osascript -e 'tell app "System Events" to keystroke "s" using command down'
sleep 2
osascript -e 'tell app "Ableton Live 12 Suite" to quit'
