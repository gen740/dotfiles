#!/usr/bin/env zsh
if ! whence zgen > /dev/null; then
  git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

echo "export ZDOTDIR=${HOME}/.dotfiles" >> ~/.zshenv

ln -sf `pwd`/.tmux.conf $HOME/.tmux.conf
ln -sf `pwd`/wezterm/.wezterm.lua $HOME/.wezterm.lua
ln -sf `pwd`/skhd $HOME/.config/skhd
ln -sf `pwd`/yabai $HOME/.config/yabai
ln -sf `pwd`/git $HOME/.config/git

# terminfo for wezterm
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile
