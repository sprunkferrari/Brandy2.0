BRANDY is a toolkit made of multiple scripts, for the purpose of automating a live show which integrates many devices in a network, transfers audio streams via Dante(R) protocol and Dante devices, USB/MIDI streams via VIRTUALHERE and Raspberry devices.

Things BRANDY can do:

- Show the status of the network (brandy status)
- Sync a project file between multiple computers (brandy sync)
- Launch a project file across multiple computers (brandy launch)
- End a session and shut down multiple computers (brandy terminate)
- End a session, reboot multiple computers, relaunch same session (brandy reboot)

To install BRANDY:

$ git clone Brandy2.0 $HOME
$ ln -s $HOME/Brandy2.0/brandy $HOME/.local/bin

Before launching any command, check the definition file (definitions.zsh) first and replace to match your setup.

Prerequirements:

- Homebrew
- Coreutils (brew install coreutils)
- network-audio-control (py) https://github.com/chris-ritsen/network-audio-controller
- VirtualHere client https://www.virtualhere.com/usb_client_software

    
