#!/bin/zsh
# Script used for defining all the fixed variables in the system.
#####
export "GATEWAY"="192.168.1.1"
export "SPRUNK_MINI"="192.168.1.10"
export "JURI_MINI"="192.168.1.11"
export "SPRUNKBOOK"="192.168.1.12"
export "SPRUNK_RASPI_P6"="192.168.1.20"
export "SPRUNK_RASPI_R"="192.168.1.21"
export "JACK_RASPI"="192.168.1.23"
export "JURI_RASPI"="192.168.1.24"
export "X32_DANTE"="192.168.1.30"
export "X32_CONTROL"="192.168.1.31"
export "SPRUNK_DN30R"="192.168.1.40"
export "SPRUNK_DN30T"="192.168.1.41"
export "JURI_DN30T"="192.168.1.42"
export "ALL_DEVICES"="GATEWAY SPRUNK_MINI JURI_MINI SPRUNK_RASPI_P6 SPRUNK_RASPI_R JACK_RASPI JURI_RASPI X32_DANTE X32_CONTROL SPRUNK_DN30R SPRUNK_DN30T JURI_DN30T"
export "RASPI_DEVICES"="SPRUNK_RASPI_P6 SPRUNK_RASPI_R JACK_RASPI JURI_RASPI"
export "MAC_DEVICES"="SPRUNK_MINI JURI_MINI"
export "VIRTUALHERE_PATH"="/Applications/VirtualHereUniversal.app/Contents/MacOS/VirtualHereUniversal"
export "PRJ_PATH"="/Users/sprunk/brandy/Projects"
pingsub()
{
    ping -o -c 3 -t 2 -q $1 &> /dev/null
}
