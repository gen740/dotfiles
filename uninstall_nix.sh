#!/bin/bash

# /064   bash.bashrc
# /028   bash.bashrc.back
# /037   bashrc -> /etc/static/bashrc
# /087   bashrc.back
# /024   bashrc.before-nix-darwin
# /082   zprofile -> /etc/static/zprofile
# /038   zprofile.before-nix-darwin
# /051   zshenv -> /etc/static/zshenv
# /043   zshrc -> /etc/static/zshrc
# /009   zshrc.back
# /056   zshrc.before-nix-darwin

sudo mv -f /etc/zshrc.before-nix-darwin /etc/zshrc
sudo mv -f /etc/zshrc.backup-before-nix /etc/zshrc
sudo mv -f /etc/bashrc.before-nix-darwin /etc/bashrc
sudo mv -f /etc/bashrc.backup-before-nix /etc/bashrc
sudo mv -f /etc/bash.bashrc.backup-before-nix /etc/bash.bashrc
sudo mv -f /etc/zprofile.before-nix-darwin /etc/zprofile

sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sudo rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sudo launchctl unload /Library/LaunchDaemons/org.nixos.darwin-store.plist
sudo rm /Library/LaunchDaemons/org.nixos.darwin-store.plist

sudo dscl . -delete /Groups/nixbld
for u in $(sudo dscl . -list /Users | grep _nixbld); do sudo dscl . -delete /Users/$u; done

echo "Delete the nix line"
sleep 3
sudo vifs

sudo rm -rf /etc/synthetic.conf
sudo rm -rf /etc/nix /var/root/.nix-profile /var/root/.nix-defexpr /var/root/.nix-channels ~/.nix-profile ~/.nix-defexpr ~/.nix-channels
sudo diskutil apfs deleteVolume /nix
diskutil list
