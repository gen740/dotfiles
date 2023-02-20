#!/usr/bin/env zsh
if ! whence zgen > /dev/null; then
  git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

echo "export ZDOTDIR=${HOME}/.dotfiles" >> ~/.zshenv


SCRIPT_DIR=$(cd $(dirname $0);pwd)

ln -sf $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf
ln -sf $SCRIPT_DIR/wezterm/.wezterm.lua $HOME/.wezterm.lua
ln -sf $SCRIPT_DIR/skhd $HOME/.config/skhd
ln -sf $SCRIPT_DIR/yabai $HOME/.config/yabai
ln -sf $SCRIPT_DIR/git $HOME/.config/git

# terminfo for wezterm
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile
