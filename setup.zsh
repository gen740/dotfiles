#!/usr/bin/env zsh
if ! whence zgen > /dev/null; then
  git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

echo "export ZDOTDIR=${HOME}/.dotfiles" >> ~/.zshenv

ln -sf `pwd`/.gitconfig $HOME/.gitconfig
ln -sf `pwd`/.tmux.conf $HOME/.tmux.conf
