#!/bin/zsh
# Script used for defining all the fixed variables in the system.
#####
export "GATEWAY"="192.168.1.1"
export "SPRUNK_MINI"="192.168.1.10"
export "JURI_MINI"="192.168.1.11"
export "SPRUNK_RASPI_P6"="192.168.1.20"
export "SPRUNK_RASPI_R"="192.168.1.21"
export "JACK_RASPI"="192.168.1.23"
export "JURI_RASPI"="192.168.1.24"
export "X32DANTE"="192.168.1.30"
export "X32CONTROL"="192.168.1.31"
export "SPRUNKDN30R"="192.168.1.40"
export "SPRUNKDN30T"="192.168.1.41"
export "JURIDN30T"="192.168.1.42"
export "ALL_DEVICES"="GATEWAY SPRUNK_MINI JURI_MINI SPRUNK_RASPI_P6 SPRUNK_RASPI_R JACK_RASPI JURI_RASPI X32DANTE X32CONTROL SPRUNKDN30R SPRUNKDN30T JURIDN30T"
export "PC_DEVICES"="SPRUNK_MINI JURI_MINI SPRUNK_RASPI_P6 SPRUNK_RASPI_R JACK_RASPI JURI_RASPI"
export "MAC_DEVICES"="SPRUNK_MINI JURI_MINI"
export "VIRTUALHERE_PATH"="/Applications/VirtualHereUniversal.app/Contents/MacOS/VirtualHereUniversal"
pingsub()
{
    ping -o -c 3 -t 2 -q $1 &> /dev/null
}
