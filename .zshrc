# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                   « Zinit and Pluigns »                           │
# ┼───────────────────────────────────────────────────────────────────────┼
# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then
  zgen load romkatv/powerlevel10k powerlevel10k
  zgen load zdharma-continuum/fast-syntax-highlighting
  # zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-completions
fi

## 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# zstyle ':completion:*:default' menu select=1
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

setopt hist_ignore_dups # 開始と終了を記録
setopt EXTENDED_HISTORY
setopt share_history
setopt auto_list

LS_COLORS='di=34:fi=0:ln=33:pi=5:so=5:bd=5:cd=5:or=0101:mi=0:ex=35:*.rpm=90'
export LS_COLORS

bindkey -v
bindkey ^F forward-char
bindkey ^N down-line-or-history
bindkey ^P up-line-or-history
bindkey "^?" backward-delete-char
bindkey "^h" backward-delete-char

export REPORTTIME=10

export BAT_THEME="gruvbox-dark"
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export GIT_EDITOR=nvim
export HISTFILE=${HOME}/.dotfiles/zsh/.zsh_history # 履歴ファイルの保存先
export HISTORY_IGNORE="ls|l|s|la|ll|cd *|cd|hcd|fcd|fvi|history|exit|popd|pushd"
export HISTSIZE=5000 # メモリに保存される履歴の件数
export LANG=ja_JP.UTF-8
# export LANG=en_US.UTF-8
export MANPAGER='nvim -M +Man! -c "set nu"'
# export PAGER='nvim -M +Man! -c "set nonu"'
export MANWIDTH=999
export SAVEHIST=50000 # 履歴ファイルに保存される履歴の件数
export TERM="xterm-256color"
export VISUAL='nvim'

source $HOME/.dotfiles/zsh/custom_func.zsh
source $HOME/.dotfiles/zsh/template.zsh
source $HOME/.dotfiles/.iterm2_shell_integration.zsh
test -e "${ZDOTDIR}/.iterm2_shell_integration.zsh" && source "${ZDOTDIR}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                         « PATH »                                  │
# ┼───────────────────────────────────────────────────────────────────────┼

export PATH="$HOME/.nodebrew/current/bin/:$PATH"
export PATH="$HOME/go/bin/:$PATH"
export PATH="/Users/fujimotogen/.deno/bin:$PATH"
# export PATH="$HOME/.local/bin:$PATH"
# export PATH="$HOME/.iterm2:$PATH"
# export PATH="$HOME/.cargo/bin/:$PATH"
# export PATH="$HOME/go/bin:$PATH"
# export PATH="/usr/local/opt/arm-gcc-bin@8/bin:$PATH"
# export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
# export PATH="/usr/local/opt/llvm/bin:$PATH"
# export PATH="$HOME/.luarocks/bin:$PATH"
# export PATH="$HOME/home/Shelf/Tools/neovide/target/release:$PATH"
# export PATH="/usr/local/opt/qt@5/bin:$PATH"

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                  « Enviroment Variables »                         │
# ┼───────────────────────────────────────────────────────────────────────┼

export CC="/usr/local/opt/llvm/bin/clang++"
export C="/usr/local/opt/llvm/bin/clang"
export CMAKE_CXX_COMPILER="/usr/local/opt/llvm/bin/clang++"
export CXX="/usr/local/opt/llvm/bin/clang++"

# export CC="/usr/local/bin/g++-11"
# export C="/usr/local/bin/gcc-11"
# export CMAKE_CXX_COMPILER="/usr/local/bin/g++-11"
# export CXX=/usr/local/bin/g++-11

# export CC="/usr/local/bin/g++-9"
# export C="/usr/local/bin/gcc-9"
# export CMAKE_CXX_COMPILER="/usr/local/bin/g++-9"
# export CXX=/usr/local/bin/g++-9

# export OPENSSL_LIBRARIES=/usr/local/opt/openssl/lib
# export OPENSSL_ROOT_DIR=/usr/local/opt/openssl
# export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig:$PKG_CONFIG_PATH"
# export PKG_CONFIG_PATH="/usr/local/Cellar/gtkmm/2.24.5_8/lib/pkgconfig:$PKG_CONFIG_PATH"
# export PKG_CONFIG_PATH="/usr/local/Cellar/qt@5/5.15.2_1/lib/pkgconfig:$PKG_CONFIG_PATH"
# export PKG_CONFIG_PATH="/usr/local/opt/qt/lib/pkgconfig:$PKG_CONFIG_PATH"
# export PKG_CONFIG_PATH="/usr/local/opt/qt@5/lib/pkgconfig:$PKG_CONFIG_PATH"
# export PKG_CONFIG_PATH="/usr/local/opt/vtk@9.1/lib/pkgconfig:$PKG_CONFIG_PATH"
# export PKG_CONFIG_PATH="/usr/local/opt/pcl/lib/pkgconfig:$PKG_CONFIG_PATH"
# export PKG_CONFIG_PATH="/usr/local/Cellar/gtk+3/3.24.30/lib/pkgconfig:$PKG_CONFIG_PATH"
export PYTHON_CONFIGURE_OPTS="--enable-framework "

# export ROS_VERSION=2
# export ROS_PYTHON_VERSION=3
# export ROS_DISTRO=foxy
# export ROS_DOMAIN_ID=222

# export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
# export CXXFLAGS="-I/usr/local/Cellar/gtk+3/3.24.30/include/gtk-3.0"
# export LDFLAGS="-L/usr/local/opt/qt@5/lib"
# export CPPFLAGS="-I/usr/local/opt/qt@5/include"

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                        « Aliases »                                │
# ┼───────────────────────────────────────────────────────────────────────┼

alias ff='cd ~/Home'
alias find='fd -HI .'
alias ggg='git add --all && git commit'

if whence lsd > /dev/null ; then
  alias l='lsd'
  alias la='lsd -A'
  alias ll='lsd -Al'
  alias ls='lsd'
fi

alias maketags='ctags -RV --sort=yes --exclude="build" -o .tags'
alias updatebd=/usr/libexec/locate.updatedb
alias v='nvim'
alias vi='nvim'
alias vv='nvim'

alias vz='nvim ~/.dotfiles/.zshrc'
alias vq='nvim ~/home/Shelf/Memo/QuickMemo.md'
alias vk='cd ~/home/Shelf/qmk/keyboards/crkbd/keymaps/mykeymap && nvim ~/home/Shelf/qmk/keyboards/crkbd/keymaps/mykeymap/genf.h'
alias va='nvim ~/home/Shelf/Novel/memo.txt'
alias pcd='cd ~/.local/share/nvim/site/pack/packer/start/Preview.vim'
alias kindlegen='/Applications/Kindle\ Previewer\ 3.app/Contents/lib/fc/bin/kindlegen'

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                     « Powerlevel10k »                             │
# ┼───────────────────────────────────────────────────────────────────────┼

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.dotfiles/.p10k.zsh ]] || source ~/.dotfiles/.p10k.zsh
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

# Change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[2 q'
#
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[6 q'
#   fi
# }
# zle -N zle-keymap-select
#
# # Use beam shape cursor on startup.
# echo -ne '\e[6 q'
# # Use beam shape cursor for each new prompt.
# preexec() {
#    echo -ne '\e[6 q'
# }

# vim:foldmethod=marker:
