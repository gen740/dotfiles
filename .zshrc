# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                   « Zinit and Pluigns »                           │
# ┼───────────────────────────────────────────────────────────────────────┼
setopt PROMPT_SUBST

export PROMPT=' %F{blue}%~%f%F{#839e6c}%B$(zsh_status git_branch)%b%f '
export RPROMPT='%(?..%F{red}%?%f) %F{#999999}$(zsh_status pyenv_version)%f'

if [ -e $HOME/.local/zsh ]; then
    export FPATH="$FPATH:$HOME/.local/zsh"
fi

export LS_COLORS='di=34:fi=0:ln=33:pi=5:so=5:bd=5:cd=5:or=0101:mi=0:ex=35:*.rpm=90'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz compinit
compinit -u

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                        « Options »                                │
# ┼───────────────────────────────────────────────────────────────────────┼

setopt HIST_IGNORE_DUPS  # Duplicated commands is ignored
setopt HIST_IGNORE_SPACE # Command which start with whitespace is ignored
setopt EXTENDED_HISTORY  # Record timestamp
setopt AUTO_LIST         # Automatically list choices on an ambiguous completion.
setopt SHARE_HISTORY     # Share History among ttys

export FZF_DEFAULT_OPTS="--border=none --height=$(($(tput line) * 2 / 5)) --scroll-off=3 --no-mouse --prompt=\  --pointer=\  --color='pointer:blue,border:gray,label:yellow'"

h() {
    dirname=`fd -c never . ~/home/ -aHI --type d \
        --exclude .git                           \
        --exclude build                          \
        --exclude _build                         \
        --exclude .build                         \
        --exclude mbed-os                        \
        --exclude .cache                         \
        --exclude node_modules                   \
        --exclude cmake_build                    \
        --exclude bin                            \
        --exclude keyboards                      \
        --exclude tests                          \
        --exclude boost-for-raspi                \
        --exclude typings                        \
        --exclude external                       \
        --exclude .deps                          \
        | fzf`
    if [[ $dirname == ""  ]]; then
    else
        pushd $dirname > /dev/null
    fi
    unset dirname
}

stty stop undef # c-s でフリーズしないようにする

bindkey -e

export WORDCHARS='[]~!$%'
export REPORTTIME=30

export BAT_THEME="gruvbox-dark"
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export GIT_EDITOR=nvim
export HISTFILE=${HOME}/.dotfiles/zsh/.zsh_history # 履歴ファイルの保存先
export HISTORY_IGNORE="ls|l|s|la|ll|cd *|cd|hcd|fcd|fvi|history|exit|popd|pushd|t|v|vi|vim|nvim|v *|vi *|vim *|nvim *|tmux|r"
export HISTSIZE=5000 # メモリに保存される履歴の件数
export LANG=en_US.UTF-8
export LESSCHARSET=utf-8
export MANWIDTH=100
export SAVEHIST=100000 # 履歴ファイルに保存される履歴の件数
export VISUAL='nvim'
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export HOMEBREW_VERBOSE=1
export HOMEBREW_NO_ENV_HINT=1

export MANPAGER="nvim +Man!"
export PAGER=less

export OPENBLAS_NUM_THREADS=8
export GOTO_NUM_THREADS=8
export OMP_NUM_THREADS=8

[ -f ~/.fzf.zsh ]                                && source ~/.fzf.zsh
[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ] && source /usr/local/opt/fzf/shell/key-bindings.zsh
[ -f /usr/share/fzf/key-bindings.zsh ]           && source /usr/share/fzf/key-bindings.zsh
[ -f ~/.zshrc_local ]                            && source ~/.zshrc_local
[ -f ~/.zshrc ]                                  && source ~/.zshrc
[ -f ~/.dotfiles/lazy_load.zsh ]                 && source ~/.dotfiles/lazy_load.zsh

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                    « PATH and Alias »                             │
# ┼───────────────────────────────────────────────────────────────────────┼

# Homebrew PATH
export PATH="/usr/local/sbin:$PATH"

whence deno > /dev/null   && export PATH="$HOME/.deno/bin:$PATH"

[ -d /usr/local/go ]    && export PATH=/usr/local/go/bin:$PATH  \
    || [ -d $HOME/go ]  && export PATH=$HOME/go/bin:$PATH
[ -d /usr/local/mysql ] && export PATH=$PATH:/usr/local/mysql/bin
[ -d $HOME/.local/bin ] && export PATH="$HOME/.local/bin:$PATH"
[ -d $HOME/.cargo/env ] && source $HOME/.cargo/env \
    || [ -d $HOME/.cargo/bin ] && export PATH=$HOME/.cargo/bin:$PATH
[ -d /home/linuxbrew/.linuxbrew ]   && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
[ -d ~/.linuxbrew ]                 && eval "$(~/.linuxbrew/bin/brew shellenv)"

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
    [ -e $HOME/.config/nvim ] && alias nvconf="nvim $HOME/.config/nvim/init.lua -c 'cd $HOME/.config/nvim'"
}

alias gs='git ps'


if whence tmux > /dev/null ; then
    if [[ -z $TMUX && -z $NVIM ]]; then # Start tmux on Login
        tmux attach || tmux new -s Main
    fi
fi

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# vim:foldmethod=marker:
