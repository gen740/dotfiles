# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                   « Zinit and Pluigns »                           │
# ┼───────────────────────────────────────────────────────────────────────┼
# ### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit

zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node
zinit ice wait'0'
zinit ice depth=1
zinit light romkatv/powerlevel10k
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

## 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1 
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' menu select=2
autoload -Uz compinit
compinit

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                        « Options »                                │
# ┼───────────────────────────────────────────────────────────────────────┼
if [[ ! -n $TMUX ]]; then # Start tmux on Login
  tmux new-session
fi

LS_COLORS='di=34:fi=0:ln=33:pi=5:so=5:bd=5:cd=5:or=0101:mi=0:ex=35:*.rpm=90'
export LS_COLORS
setopt hist_ignore_dups # 開始と終了を記録
setopt EXTENDED_HISTORY

bindkey -v
bindkey ^F forward-char
bindkey ^N down-line-or-history
bindkey ^P up-line-or-history
bindkey "^?" backward-delete-char
bindkey "^h" backward-delete-char

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                         « PATH »                                  │
# ┼───────────────────────────────────────────────────────────────────────┼
# set rtp+=/usr/local/opt/fzf
# export PATH="$HOME/.local/bin:$PATH"
# export PATH="$HOME/.iterm2:$PATH"
# export PATH="$HOME/.nodebrew/current/bin/:$PATH"
# export PATH="$HOME/.cargo/bin/:$PATH"
# export PATH="/usr/local/opt/arm-gcc-bin@8/bin:$PATH"
# export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="$HOME/.luarocks/bin:$PATH"
export PATH="$HOME/home/Shelf/Tools/neovide/target/release:$PATH"
# export PATH="/usr/local/opt/qt@5/bin:$PATH"

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                  « Enviroment Variables »                         │
# ┼───────────────────────────────────────────────────────────────────────┼
# export CC="/usr/local/opt/llvm/bin/clang++"
# export C="/usr/local/opt/llvm/bin/clang"
# export CC="/usr/local/bin/g++-9"
# export C="/usr/local/bin/gcc-9"
# alias gcc="/usr/local/opt/llvm/bin/clang"
# export CC="/usr/local/bin/g++-11"
# export CMAKE_CXX_COMPILER="/usr/local/opt/llvm/bin/clang++"
# export CXX="/usr/local/opt/llvm/bin/clang++"
# export CMAKE_CXX_COMPILER="/usr/local/bin/g++-11"
# export CXX=/usr/local/bin/g++-11
# export CMAKE_CXX_COMPILER="/usr/local/bin/g++-10"
# export CXX=/usr/local/bin/g++-10
# export CMAKE_CXX_COMPILER="/usr/local/bin/g++-9"
# export CXX=/usr/local/bin/g++-9
# export CPPFLAGS="-I/usr/local/opt/ruby/include $CPPFLAGS"
# export CPPFLAGS="-I/usr/local/opt/zlib/include $CPPFLAGS"
# export PATH="$HOME/.local/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/zlib/lib $LDFLAGS"
# # export PKG_CONFIG_PATH="/usr/local/opt/qt@5/lib/pkgconfig"
# export PYTHONHOME="$HOME/.pyenv/versions/3.8.6/lib/python3.8"
# export PYTHONPATH="$HOME/.pyenv/versions/3.8.6/lib:$HOME/.pyenv/versions/3.8.6/Python.framework/Versions/3.8/lib/python3.8/site-packages:$PYTHONPATH"
# export Qt5_DIR=/usr/local/opt/qt5
# export BAT_THEME="gruvbox-dark"
# export CPPFLAGS="-I/usr/local/opt/qt@5/include"
export TERM="xterm-256color"
# export EDITOR='nvim'
# export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# export GIT_EDITOR=nvim
# export LDFLAGS="-L/usr/local/opt/qt@5/lib $LDFLAGS"
# export LIBRARY_PATH=/usr/local/lib
export OPENSSL_LIBRARIES=/usr/local/opt/openssl/lib
export OPENSSL_ROOT_DIR=/usr/local/opt/openssl
# export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig:$PKG_CONFIG_PATH"
# export PYTHON_CONFIGURE_OPTS="--enable-framework "
export LANG=ja_JP.UTF-8
export SAVEHIST=50000 # 履歴ファイルに保存される履歴の件数
export HISTFILE=${HOME}/.dotfiles/zsh/.zsh_history # 履歴ファイルの保存先
export HISTSIZE=5000 # メモリに保存される履歴の件数
export HISTORY_IGNORE="ls:l:s"
source $HOME/.dotfiles/zsh/custom_func.zsh
source $HOME/.dotfiles/zsh/template.zsh
export ROS_VERSION=2
export ROS_PYTHON_VERSION=3
export ROS_DISTRO=foxy
export ROS_DOMAIN_ID=222
alias updatebd=/usr/libexec/locate.updatedb

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                        « Aliases »                                │
# ┼───────────────────────────────────────────────────────────────────────┼
alias activate='source bin/activate'
alias att='mpv /System/Library/Sounds/Funk.aiff'
alias ff='cd ~/Home'
alias find='fd -HI .'
alias ggg='git add --all && git commit'
alias la='lsd -A'
alias ll='lsd -Al'
alias ls='lsd'
alias l='lsd'
alias maketags='ctags -RV --sort=yes --exclude="build" -o .tags'
alias tp="open -a /Applications/Typora.app"

alias v='nvim'
alias vi='nvim'
alias vv='nvim'
# alias vi='change; nvim'
# alias vv='change_f; nvim'
alias w3m='w3m -sixel -o display_image=1'
alias my_syncro='rsync -avz --exclude="*.o" --exclude="*.so" --exclude="*.a" --exclude="*.cmake"    \
  --exclude="CMakeFiles" --exclude="Makefile" --exclude="*.gch" --exclude="*.hex" --exclude="*.elf" \
  --exclude=".git" --exclude="build*"'

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                     « Powerlevel10k »                             │
# ┼───────────────────────────────────────────────────────────────────────┼
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=11
typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION=' ' # ﬌      
typeset -g POWERLEVEL9K_FOLDER_ICON=''
typeset -g POWERLEVEL9K_HOME_ICON=''
typeset -g POWERLEVEL9K_HOME_SUB_ICON=''
typeset -g POWERLEVEL9K_FOLDER_ICON=''
typeset -g POWERLEVEL9K_ETC_ICON=''
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='N' # ''
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V' # ''
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=20

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
