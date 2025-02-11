#!/bin/zsh
# Script used for defining the fixed variables and subroutines in the system.
#####
export "GATEWAY_AP"="192.168.1.1"
export "SPRUNKMINI"="192.168.1.10"
export "JURIMINI"="192.168.1.11"
export "SPRUNKBOOK"="192.168.1.12"
export "SPRUNKRASPI_P6"="192.168.1.20"
export "SPRUNKRASPI_R"="192.168.1.21"
export "JACKRASPI"="192.168.1.23"
export "JURIRASPI"="192.168.1.24"
export "X32DANTE"="192.168.1.30"
export "X32CONTROL"="192.168.1.31"
export "SPRUNKDN30R"="192.168.1.40"
export "SPRUNKDN30T"="192.168.1.41"
export "JURIDN30T"="192.168.1.42"

export "ALL_DEVICES"="GATEWAY_AP SPRUNKMINI JURIMINI SPRUNKRASPI_P6 SPRUNKRASPI_R JACKRASPI JURIRASPI X32DANTE X32CONTROL SPRUNKDN30R SPRUNKDN30T JURIDN30T"
export "RASPI_DEVICES"="SPRUNKRASPI_P6 SPRUNKRASPI_R JACKRASPI JURIRASPI"
export "MAC_DEVICES"="SPRUNKMINI JURIMINI"
export "VIRTUALHERE_PATH"="/Applications/VirtualHereUniversal.app/Contents/MacOS/VirtualHereUniversal"
export "BRANDY_PATH"="$HOME/Brandy2.0"
export "PRJ_PATH"="$HOME/Brandy2.0/Projects"
pingsub()
{
    ping -o -c 3 -t 2 -q $1 &> /dev/null
}
notifysub()
{
    sendosc 127.0.0.1 39051 /notify/toast s $1 $2
}
