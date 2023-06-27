# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                   « Zinit and Pluigns »                           │
# ┼───────────────────────────────────────────────────────────────────────┼
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
    zgen load romkatv/powerlevel10k powerlevel10k
    zgen load zdharma-continuum/fast-syntax-highlighting
    zgen load zsh-users/zsh-completions
    zgen load lukechilds/zsh-nvm
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.dotfiles/.p10k.zsh ]] || source ~/.dotfiles/.p10k.zsh

if [ -e $HOME/.local/zsh ]; then
    export FPATH="$FPATH:/Users/fujimotogen/.local/zsh"
fi

## 補完で小文字でも大文字にマッチさせる
export LS_COLORS='di=34:fi=0:ln=33:pi=5:so=5:bd=5:cd=5:or=0101:mi=0:ex=35:*.rpm=90'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz compinit
compinit

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                        « Options »                                │
# ┼───────────────────────────────────────────────────────────────────────┼

setopt HIST_IGNORE_DUPS  # Duplicated commands is ignored
setopt HIST_IGNORE_SPACE # Command which start with whitespace is ignored
setopt EXTENDED_HISTORY  # Record timestamp
setopt AUTO_LIST         # Automatically list choices on an ambiguous completion.
setopt SHARE_HISTORY     # Share History among ttys

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

export OPENBLAS_NUM_THREADS=16
export GOTO_NUM_THREADS=16
export OMP_NUM_THREADS=16

[ -f ~/.dotfiles/zsh/custom_func.zsh ]  && source ~/.dotfiles/zsh/custom_func.zsh
[ -f ~/.dotfiles/zsh/template.zsh ]     && source ~/.dotfiles/zsh/template.zsh
[ -f ~/.fzf.zsh ]                       && source ~/.fzf.zsh
[ -f ~/.zshrc_local ]                   && source ~/.zshrc_local
[ -f ~/.zshrc ]                         && source ~/.zshrc

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                    « PATH and Alias »                             │
# ┼───────────────────────────────────────────────────────────────────────┼

# [ -e /opt/homebrew ]    && export PATH=/opt/homebrew/bin:$PATH
# [ -e $HOME/.local/homebrew ]    && export PATH=$HOME/.local/homebrew/bin:$PATH

# Homebrew PATH
export PATH="/usr/local/sbin:$PATH"

whence deno > /dev/null   && export PATH="$HOME/.deno/bin:$PATH"

[ -d /usr/local/go ]    && export PATH=/usr/local/go/bin:$PATH  \
    || [ -d $HOME/go ]  && export PATH=$HOME/go/bin:$PATH
[ -d /usr/local/mysql ] && export PATH=$PATH:/usr/local/mysql/bin
[ -d $HOME/.local/bin ] && export PATH="$HOME/.local/bin:$PATH"
[ -d $HOME/.cargo/env ] && source $HOME/.cargo/env \
    || [ -d $HOME/.cargo/bin ] && export PATH=$HOME/.cargo/bin:$PATH
# [ -d /usr/local/opt/llvm/bin ] && export PATH="/usr/local/opt/llvm/bin:$PATH"
[ -d /usr/local/opt/google-benchmark ] && export benchmark_DIR=/usr/local/opt/google-benchmark
[ -d $HOME/vcpkg ]                     && export VCPKG_ROOT="$HOME/vcpkg"
[ -d /home/linuxbrew/.linuxbrew ]   && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
[ -d ~/.linuxbrew ]                 && eval "$(~/.linuxbrew/bin/brew shellenv)"
[ -d /opt/gRPC ]                    && {
    export PATH=/opt/gRPC/bin:$PATH
    export CMAKE_PREFIX_PATH=/opt/gRPC/lib/cmake:$CMAKE_PREFIX_PATH
}

## Aliases
whence fdfind > /dev/null && alias fd=fdfind
whence fd > /dev/null     && alias find='fd -HI .'
whence lsd > /dev/null && {
    alias la='lsd -A'
    alias ll='lsd -Al'
    alias ls='lsd'
}
whence nvim > /dev/null && { 
    alias v='nvim'
    alias vi='nvim'
}

[ -e $HOME/.config/nvim ] && alias nvconf="nvim $HOME/.config/nvim/init.lua -c 'cd $HOME/.config/nvim'"

# if whence pyenv > /dev/null ; then
if [ -e $HOME/.pyenv ]; then
    if [[ $OSTYPE =~ 'darwin*' ]]; then
        # export PYTHON_CONFIGURE_OPTS="--enable-framework=~/.local/frameworks"
        export PYTHON_CONFIGURE_OPTS="--enable-shared"
    else
        export PYTHON_CONFIGURE_OPTS="--enable-shared"
    fi
    export PIPX_DEFAULT_PYTHON=~/.pyenv/versions/pipx/bin/python3
    export PATH="$HOME/.pyenv/bin:$PATH"
    export PYENV_ROOT="$HOME/.pyenv"
    ZSH_PYENV_LAZY_VIRTUALENV=true
    zgen load davidparsson/zsh-pyenv-lazy
    # eval "$(pyenv init -)"
    # eval "$(pyenv virtualenv-init -)"
fi

if [ -e $HOME/.local/tools/emsdk/emsdk_env.sh ]; then
    emsactivate() {
        $HOME/.local/tools/emsdk/emsdk activate latest > /dev/null &> /dev/null
        source $HOME/.local/tools/emsdk/emsdk_env.sh > /dev/null &> /dev/null
    }
    emcc() {
        unset -f emcc
        emsactivate()
        emcc "$@"
    }
fi

typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=37
typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION=''
typeset -g POWERLEVEL9K_FOLDER_ICON=''
typeset -g POWERLEVEL9K_HOME_ICON=''
typeset -g POWERLEVEL9K_HOME_SUB_ICON=''
typeset -g POWERLEVEL9K_FOLDER_ICON=''
typeset -g POWERLEVEL9K_ETC_ICON=''
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='N' # ''
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V' # ''
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL="  "
typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=30


if whence tmux > /dev/null ; then
    if [[ -z $TMUX && -z $NVIM ]]; then # Start tmux on Login
        tmux attach || tmux new -s Main
    fi
fi

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# vim:foldmethod=marker:
