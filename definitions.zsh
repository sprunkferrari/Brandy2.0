#!/bin/zsh
# Script used for defining all the fixed variables in the system.
#####
$GATEWAY=192.168.1.1 > $1
$SPRUNK_MINI=192.168.1.10 > $2
$JURI_MINI=192.168.1.11 > $3
$SPRUNK_RASPI_P6=192.168.1.20 > $4
$SPRUNK_RASPI_RACK=192.168.1.21 > $5
$JACK_RASPI=192.168.1.23 > $6
$JURI_RASPI=192.168.1.24 > $7
$X32_DANTE=192.168.1.30 > $8
$X32_CONTROL=192.168.1.31 > $9
$SPRUNK_DN30R=192.168.1.40 > $10
$SPRUNK_DN30T=192.168.1.41 > $11
$JURI_DN30T=192.168.1.42 > $12
  
  

for i in $*
  do export $i
  done

exit
