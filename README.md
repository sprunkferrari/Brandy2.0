BRANDY is a toolkit made of multiple scripts, for the purpose of automating a live show which integrates many devices in a network, transfers audio streams via Dante(R) protocol and Dante devices, USB/MIDI streams via VIRTUALHERE and Raspberry devices.

Things BRANDY can do:

- Show the status of the network (brandy status)
- Sync a project folder between multiple computers (brandy sync)
- Launch a project file across multiple computers (brandy launch <prjname (opt)>)
- End a session (brandy quit)
- End a session and shut down multiple computers (brandy terminate)
- Istantly make Dante subscriptions from a file (brandy dante <configname>)

To install BRANDY:

$ git clone sprunkferrari/Brandy2.0 Brandy2.0
$ ln -s Brandy2.0/brandy .local/bin/

Before launching any command, check the definition file (definitions.zsh) first and replace to match your setup.

Prerequirements:

- XCODE 
$ xcode-select --install
- Homebrew
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
- Rust 
$ curl https://sh.rustup.rs -sSf | sh 
- Coreutils 
$ brew install coreutils
- Sendosc https://github.com/yoggy/sendosc
$ brew install yoggy/tap/sendosc
- Dante-CLI  https://crates.io/crates/dante-cli
$ cargo install dante-cli
- VirtualHere client https://www.virtualhere.com/usb_client_software
