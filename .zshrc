# Reset the PATH
export PATH=/usr/bin:/bin:/usr/sbin:/sbin
export PATH=/Users/fujimotogen/.nix-profile/bin:/nix/var/nix/profiles/default/bin${PATH:+:}$PATH
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

[ -d /usr/local/bin ]                     && export PATH=/usr/local/bin:$PATH
[ -d /opt/homebrew/bin ]                  && export PATH=/opt/homebrew/bin:$PATH

eval "$(starship init zsh)"

#──────────────────────────────────────────────────────────────────────────────
#                            completion settings
#──────────────────────────────────────────────────────────────────────────────

[ -e $HOME/.local/zsh ] && export FPATH="$FPATH:$HOME/.local/zsh"
[ -e /opt/homebrew/share/zsh/site-functions ] && export FPATH="$FPATH:/opt/homebrew/share/zsh/site-functions"
[ -e $HOME/.dotfiles/zsh ] && export FPATH="$FPATH:$HOME/.dotfiles/zsh"

export LS_COLORS='di=1;31:ln=37:so=32:pi=33:ex=31:bd=1;35;40:cd=1;35;43:su=1;30;41:sg=1;30;43:tw=1;30;42:ow=1;30;44'
export LSCOLORS='Bxhxcxdxbxegedabagacad'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

autoload -Uz compinit
compinit -u
setopt AUTO_LIST             # Automatically list choices on an ambiguous completion.

#──────────────────────────────────────────────────────────────────────────────
#                                   Options
#──────────────────────────────────────────────────────────────────────────────
export FZF_DEFAULT_OPTS="--border=none --height=24 --scroll-off=3 --no-mouse --prompt=\  --pointer=\  "
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

function h() {
    if [ -e $HOME/home ]; then
        dirname=`fd -c never . $HOME/home/ -aH --type d | fzf`
    else
        dirname=`fd -c never . $HOME/ -aH --type d | fzf`
    fi

    if [[ $dirname == ""  ]]; then
        return 1
    fi
    pushd $dirname > /dev/null
    unset dirname
}

stty stop undef # do not stop the terminal with C-s

bindkey -e

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export WORDCHARS='!$%'
export REPORTTIME=10
export TIMEFMT='%*E %*U %*S CPU: %P Memory: %M KB # %J'
export EDITOR='nvim'
export GIT_EDITOR=nvim
export LANG=en_US.UTF-8
export LESSCHARSET=utf-8
export MANWIDTH=100
export VISUAL='nvim'
export MANPAGER="nvim +Man!"
export PAGER=less

export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export GOPATH=$XDG_DATA_HOME/go
export CARGO_HOME=$HOME/.cargo
export MPLCONFIGDIR=$XDG_CACHE_HOME/matplotlib
export IPYTHONDIR=$XDG_CACHE_HOME/ipython
export JUPYTER_CONFIG_DIR=$XDG_CACHE_HOME/jupyter

export PYTHON_HISTORY=$XDG_DATA_HOME/python/history
export ROOT_HIST=0
export CMAKE_EXPORT_COMPILE_COMMANDS=1

#──────────────────────────────────────────────────────────────────────────────
#                               PATH and Alias
#──────────────────────────────────────────────────────────────────────────────
[ -f $HOME/.dotfiles/zsh_history_config.zsh ]           && source $HOME/.dotfiles/zsh_history_config.zsh
whence fzf > /dev/null                                  && eval "$(fzf --zsh)"
[ -f $HOME/.zshrc_local ]                               && source $HOME/.zshrc_local
[ -f $HOME/.dotfiles/lazy_load.zsh ]                    && source $HOME/.dotfiles/lazy_load.zsh
whence deno > /dev/null                                 && export PATH="$HOME/.deno/bin:$PATH"
[ -d $HOME/.local/bin ]                                 && export PATH="$HOME/.local/bin:$PATH"
[ -d $CARGO_HOME/env ]                                  && source $CARGO_HOME/env \
    || [ -d $CARGO_HOME/bin ]                           && export PATH=$CARGO_HOME/bin:$PATH
[ -d /usr/local/go ]                                    && export PATH=/usr/local/go/bin:$PATH
[ -d $HOME/.volta ]                                     && export VOLTA_HOME="$HOME/.volta" && export PATH="$VOLTA_HOME/bin:$PATH"

# load linuxbrew
[ -d /home/linuxbrew/.linuxbrew ] \
    && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
    && export LIBRARY_PATH=${LIBRARY_PATH:+$LIBRARY_PATH:}/home/linuxbrew/.linuxbrew/lib \
    && export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}/home/linuxbrew/.linuxbrew/lib

whence direnv > /dev/null && eval "$(direnv hook zsh)"

## Aliases
whence fdfind > /dev/null && alias fd=fdfind

whence nvim > /dev/null && {
    alias v='nvim'
    alias vi='nvim'
}

alias ls='ls --color -F'
alias gs='git ps'
alias dr='direnv allow'

if [ "$1" != "--no-tmux" ]; then
    whence tmux > /dev/null && [[ -z $TMUX && -z $NVIM ]] && (tmux attach || tmux new -s Main)
fi

docker_login() {
    if [[ "$1" == "brew" ]]; then
        target="gen740/ubuntu-22.04-linuxbrew"
    else
        target="gen740/ubuntu-22.04"
    fi

    docker run -it --rm                                                     \
        -v $HOME/.config/github-copilot:/home/gen740/.config/github-copilot \
        -v $HOME/.config/gh:/home/gen740/.config/gh                         \
        -v $HOME/home:/home/gen740/home                                     \
        -w /home/gen740 ${target} /bin/zsh
    unset target
}
