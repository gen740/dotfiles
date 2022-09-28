# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                   « Zinit and Pluigns »                           │
# ┼───────────────────────────────────────────────────────────────────────┼
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
    zgen load romkatv/powerlevel10k powerlevel10k
    zgen load zdharma-continuum/fast-syntax-highlighting
    zgen load zsh-users/zsh-completions
    zgen load sobolevn/wakatime-zsh-plugin
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.dotfiles/.p10k.zsh ]] || source ~/.dotfiles/.p10k.zsh

if [ -e $HOME/.local/zsh ]; then
    export FPATH="$FPATH:/Users/fujimotogen/.local/zsh"
fi

## 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit
compinit


# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                        « Options »                                │
# ┼───────────────────────────────────────────────────────────────────────┼

setopt HIST_IGNORE_DUPS # Duplicated commands is ignored
setopt HIST_IGNORE_SPACE # Command which start with whitespace is ignored
setopt EXTENDED_HISTORY # Record timestamp
setopt SHARE_HISTORY # Share History among ttys
setopt AUTO_LIST

LS_COLORS='di=34:fi=0:ln=33:pi=5:so=5:bd=5:cd=5:or=0101:mi=0:ex=35:*.rpm=90'
export LS_COLORS

stty stop undef # c-s でフリーズしないようにする

bindkey -e

export WORDCHARS='[]~!$%'
export REPORTTIME=10

export BAT_THEME="gruvbox-dark"
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export GIT_EDITOR=nvim
export HISTFILE=${HOME}/.dotfiles/zsh/.zsh_history # 履歴ファイルの保存先
export HISTORY_IGNORE="ls|l|s|la|ll|cd *|cd|hcd|fcd|fvi|history|exit|popd|pushd"
export HISTSIZE=5000 # メモリに保存される履歴の件数
export LANG=ja_JP.UTF-8
export MANWIDTH=100
export SAVEHIST=100000 # 履歴ファイルに保存される履歴の件数
export VISUAL='nvim'
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export MANPAGER="col -b -x|nvim -R -c 'set ft=man nolist nomod noma' -"
export PAGER=less

export OPENBLAS_NUM_THREADS=16
export GOTO_NUM_THREADS=16
export OMP_NUM_THREADS=16
 
# export PYTHON_CONFIGURE_OPTS="--enable-shared"
export PYTHON_CONFIGURE_OPTS="--enable-framework"

[ -f ~/.dotfiles/zsh/custom_func.zsh ] && source ~/.dotfiles/zsh/custom_func.zsh
[ -f ~/.dotfiles/zsh/template.zsh ] && source ~/.dotfiles/zsh/template.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f "/Users/fujimotogen/.ghcup/env" ] && source "/Users/fujimotogen/.ghcup/env" # ghcup-env

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                    « PATH and Alias »                             │
# ┼───────────────────────────────────────────────────────────────────────┼

if [ -e ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

if [ -e ~/.zshrc ]; then
    source ~/.zshrc
fi

if whence deno > /dev/null ; then
    export PATH="$HOME/.deno/bin:$PATH"
fi

if whence go > /dev/null ; then
    export PATH="$HOME/go/bin/:$PATH"
fi

if [ -e $HOME/.local/bin ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -e $HOME/.cargo/env ]; then
    source $HOME/.cargo/env
fi

if [ -e /usr/local/go ]; then
    export PATH=$PATH:/usr/local/go/bin
fi

if [ -e $HOEM/.pyenv/bin ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
fi

if whence pyenv > /dev/null ; then
    export PYENV_ROOT="$HOME/.pyenv"
    eval "$(pyenv init -)"
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
fi

if whence rbenv > /dev/null ; then
    rbenv () {
        unset -f rbenv
        eval "$(pyenv init --path)"
        eval "$(pyenv virtualenv-init -)"
        eval "$(rbenv init - zsh)"
        rbenv "$@"
    }
fi

if whence fdfind > /dev/null; then
    alias fd=fdfind
fi

if [ -e /usr/local/opt/llvm/bin ]; then
    export PATH="/usr/local/opt/llvm/bin:$PATH"
fi

if [ -e /opt/OpenBLAS ]; then
  export OpenBLAS_DIR=/opt/OpenBLAS
  export PKG_CONFIG_PATH=/opt/OpenBLAS/lib/pkgconfig:$PKG_CONFIG_PATH
fi

if [ -e /usr/local/share/eigen3/cmake ]; then
    export CMAKE_PREFIX_PATH=/usr/local/share/eigen3/cmake:$CMAKE_PREFIX_PATH
fi

if [ -e /usr/local/opt/google-benchmark ]; then
    export benchmark_DIR=/usr/local/opt/google-benchmark
fi

if whence fd > /dev/null ; then
    alias find='fd -HI .'
fi

if whence lsd > /dev/null ; then
    alias la='lsd -A'
    alias ll='lsd -Al'
    alias ls='lsd'
fi

if whence nvim > /dev/null ; then
    alias v='nvim'
    alias vi='nvim'
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

# LABRARIES PATH
# export LIBRARY_PATH="/usr/local/lib:$LIBRARY_PATH"
# export LIBRARY_PATH="/opt/intel/oneapi/mkl/latest/lib:$LIBRARY_PATH"
# export LIBRARY_PATH="$HOME/.local/lib:$LIBRARY_PATH"
# export CPLUS_INCLUDE_PATH="/usr/local/include:$CPLUS_INCLUDE_PATH"
# export CPLUS_INCLUDE_PATH="$HOME/.local/include:$CPLUS_INCLUDE_PATH"

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

if [[ ! -n $TMUX && ! -n $NVIM ]]; then # Start tmux on Login
    # tmux new-session
    tmux attach || tmux
fi

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# vim:foldmethod=marker:
