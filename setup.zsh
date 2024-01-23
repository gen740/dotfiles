#!/bin/zsh

## verbose
if [ "$1" = "-v" ]; then
  set -x
fi

echo "export ZDOTDIR=${HOME}/.dotfiles" >> ~/.zshenv

SCRIPT_DIR=$(cd $(dirname $0);pwd)


function() link() {
  [ -f $HOME/$1 ] && { 
    echo "relinking $HOME/$1" && rm $HOME/$1
  } || {
    echo "linking $HOME/$1"
  }
  ln -sf $SCRIPT_DIR/$1 $HOME/$1
}

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

link .tmux.conf
link .wezterm.lua
linkconfig skhd
linkconfig yabai
linkconfig git
linkconfig lazygit
linkconfig yamlfmt
linkconfig clangd
linkconfig alacritty

unset SCRIPT_DIR
unset -f link
unset -f linkconfig

# terminfo for wezterm
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile
