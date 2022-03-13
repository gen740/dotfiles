# source ~/ros2_foxy/ros2-osx/setup.zsh &> /dev/null

export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"


if whence pyenv > /dev/null ; then
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi

if whence rbenv > /dev/null ; then
  eval "$(rbenv init - zsh)"
fi

# source $HOME/.cargo/env
