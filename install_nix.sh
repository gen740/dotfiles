#!/bin/bash

bash <(curl -L https://nixos.org/nix/install) --daemon
exec $SHELL -l
sudo rm /etc/ssl/certs/ca-certificates.crt
sudo ln -s /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
sudo rm /etc/ssl/certs/ca-certificates.crt
./result/bin/darwin-installer
exec $SHELL -l
darwin-rebuild switch ~/.dotfiles/nix-darwin
