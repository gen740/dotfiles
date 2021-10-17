# source ~/ros2_foxy/ros2-osx/setup.zsh &> /dev/null

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init -)"
source $HOME/.cargo/env
