#!/bin/zsh

## verbose
if [ "$1" = "-v" ]; then
  set -x
fi

grep -qxF 'export ZDOTDIR=$HOME/.dotfiles' ~/.zshenv || echo 'export ZDOTDIR=$HOME/.dotfiles' >> ~/.zshenv

SCRIPT_DIR=$(cd $(dirname $0);pwd)

function() linkconfig() {
  [ -f $HOME/.config/$1 ] && { 
    echo "relinking $HOME/.config/$1" && rm $HOME/.config/$1
  } || [ -d $HOME/.config/$1 ] && {
    echo "relinking dir $HOME/.config/$1" && rm $HOME/.config/$1
  } || {
    echo "linking $HOME/.config/$1"
  }
  ln -sf $SCRIPT_DIR/$1 $HOME/.config/$1
}

linkconfig nix-darwin
linkconfig starship.toml

unset SCRIPT_DIR
unset -f linkconfig
