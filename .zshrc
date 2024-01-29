# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                   « Zinit and Pluigns »                           │
# ┼───────────────────────────────────────────────────────────────────────┼
setopt PROMPT_SUBST

[ -e $HOME/.local/zsh ] && export FPATH="$FPATH:$HOME/.local/zsh"
[ -e $HOME/.dotfiles/zsh ] && export FPATH="$FPATH:$HOME/.dotfiles/zsh"

export LS_COLORS='di=34:fi=0:ln=33:pi=5:so=5:bd=5:cd=5:or=0101:mi=0:ex=35:*.rpm=90'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz compinit
compinit -u

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                        « Options »                                │
# ┼───────────────────────────────────────────────────────────────────────┼

setopt AUTO_LIST             # Automatically list choices on an ambiguous completion.

export FZF_DEFAULT_OPTS="--border=none --height=24 --scroll-off=3 --no-mouse --prompt=\  --pointer=\  --color='pointer:blue,border:gray,label:yellow'"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

function h() {
    [ -e $HOME/home ]                                           \
        && dirname=`fd -c never . ~/home/ -aH --type d | fzf`   \
        || dirname=`fd -c never . ~/ -aH --type d | fzf`

    if [[ $dirname == ""  ]]; then
    else
        pushd $dirname > /dev/null
    fi
    unset dirname
}

stty stop undef # c-s でフリーズしないようにする

bindkey -e

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export WORDCHARS='!$%'
export REPORTTIME=30
export EDITOR='nvim'
export GIT_EDITOR=nvim
export LANG=en_US.UTF-8
export LESSCHARSET=utf-8
export MANWIDTH=100
export VISUAL='nvim'
export MANPAGER="nvim +Man!"
export PAGER=less
export OPENBLAS_NUM_THREADS=16
export OMP_NUM_THREADS=16

export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export GOPATH=$XDG_DATA_HOME/go
export CARGO_HOME=$HOME/.cargo
export MPLCONFIGDIR=$XDG_CACHE_HOME/matplotlib
export IPYTHONDIR=$XDG_CACHE_HOME/ipython
export JUPYTER_CONFIG_DIR=$XDG_CACHE_HOME/jupyter

export PYTHON_HISTORY=$XDG_DATA_HOME/python/history
export ROOT_HIST=0

export CMAKE_EXPORT_COMPILE_COMMANDS=1

[ -f ~/.dotfiles/zsh_history_config.zsh ]        && source ~/.dotfiles/zsh_history_config.zsh
[ -f ~/.fzf.zsh ]                                && source ~/.fzf.zsh
[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ] && source /usr/local/opt/fzf/shell/key-bindings.zsh
[ -f /usr/share/fzf/key-bindings.zsh ]           && source /usr/share/fzf/key-bindings.zsh
[ -f ~/.zshrc_local ]                            && source ~/.zshrc_local
[ -f ~/.dotfiles/lazy_load.zsh ]                 && source ~/.dotfiles/lazy_load.zsh

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                    « PATH and Alias »                             │
# ┼───────────────────────────────────────────────────────────────────────┼

whence deno > /dev/null             && export PATH="$HOME/.deno/bin:$PATH"
[ -d $HOME/.local/bin ]             && export PATH="$HOME/.local/bin:$PATH"
[ -d $CARGO_HOME/env ]              && source $CARGO_HOME/env \
    || [ -d $CARGO_HOME/bin ]       && export PATH=$CARGO_HOME/bin:$PATH
[ -d /usr/local/go ]                && export PATH=/usr/local/go/bin:$PATH

# load linuxbrew
[ -d /home/linuxbrew/.linuxbrew ] \
    && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
    && export LIBRARY_PATH=$LIBRARY_PATH:/home/linuxbrew/.linuxbrew/lib \
    && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/linuxbrew/.linuxbrew/lib

whence direnv > /dev/null && eval "$(direnv hook zsh)"

## Aliases
whence fdfind > /dev/null && alias fd=fdfind
whence lsd > /dev/null && {
    alias la='lsd -A'
    alias ll='lsd -Al'
    alias ls='lsd'
}

whence nvim > /dev/null && {
    alias nvim='[[ $NVIM ]] && echo "cannot nest neovim" || nvim'
    alias v='nvim'
    alias vi='nvim'
}

alias gs='git ps'

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                    « PROMPT setting »                             │
# ┼───────────────────────────────────────────────────────────────────────┼

whence zsh_status > /dev/null                                                       \
  && export PROMPT=' %F{blue}%~%f%F{#839e6c}%B$(zsh_status git_branch)%b%f '        \
  || export PROMPT=' %F{blue}%~%f '
whence zsh_status > /dev/null                                                    \
  && export RPROMPT='%(?..%F{red}%?%f) %F{#999999}$(zsh_status pyenv_version)%f' \
  || export RPROMPT='%(?..%F{red}%?%f)'


if [ "$1" != "--no-tmux" ]; then
    whence tmux > /dev/null && [[ -z $TMUX && -z $NVIM ]] && (tmux attach || tmux new -s Main)
fi

docker_login() {
    docker run -it --rm                                                     \
        -v $HOME/.config/github-copilot:/home/gen740/.config/github-copilot \
        -v $HOME/.config/gh:/home/gen740/.config/gh                         \
        -v $HOME/home:/home/gen740/home                                     \
        -w /home/gen740 gen740/ubuntu-22.04 /bin/zsh
}

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# vim:foldmethod=marker:
