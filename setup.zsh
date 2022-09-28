#!/usr/bin/env zsh
if ! whence zgen > /dev/null; then
  git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

echo "export ZDOTDIR=${HOME}/.dotfiles" >> ~/.zshenv

if [[ ! -f ~/.gitconfig ]]; then
    cp -sf `pwd`/.gitconfig $HOME/.gitconfig
fi

# terminfo for wezternm
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile

ln -sf `pwd`/.tmux.conf $HOME/.tmux.conf
