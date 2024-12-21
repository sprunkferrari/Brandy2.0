#!/bin/zsh

#  terminate.zsh
#  
#
#  Created by Francesco Ferrari on 20/12/24.
#  
printf "-----------"
printf "Ready to Terminate"
printf "-----------"

. ./definitions.zsh

ssh sprunk@"$SPRUNK_MINI" ./quit.zsh
ssh sprunk@"$JURI_MINI" ./quit.zsh

ssh sprunk@"$RASPI_SPRUNK_P6" shutdown -h now
ssh sprunk@"$RASPI_SPRUNK_RACK" shutdown -h now
ssh sprunk@"$RASPI_JACK" shutdown -h now
ssh sprunk@"$RASPI_JURIJ" shutdown -h now
