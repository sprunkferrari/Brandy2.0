#!/bin/zsh

#  launcher.zsh
#  
#
#  Created by Francesco Ferrari on 20/12/24.
#

printf "--------------"
printf "Welcome Sprunk!"
printf "--------------"

. ./definitions.zsh


case i in
    ( malvax ) ssh sprunk@"$SPRUNK_MINI" zsh launch_malvax.zsh && ssh sprunk@"$JURI_MINI" zsh launch_malvax_seq.zsh
    ( lpm ) ssh sprunk@"$SPRUNK_MINI" zsh launch_lpm.zsh
    ( bper ) ssh sprunk@"$SPRUNK_MINI" zsh launch_bper.zsh
    ( * )
esac


