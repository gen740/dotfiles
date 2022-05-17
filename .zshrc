# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                   « Zinit and Pluigns »                           │
# ┼───────────────────────────────────────────────────────────────────────┼
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  zgen load romkatv/powerlevel10k powerlevel10k
  zgen load zdharma-continuum/fast-syntax-highlighting
  # zgen load spaceship-prompt/spaceship-prompt spaceship
  # zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-completions
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.dotfiles/.p10k.zsh ]] || source ~/.dotfiles/.p10k.zsh

## 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit
compinit

# eval "$(starship init zsh)"

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

# c-s でフリーズしないようにする
stty stop undef

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
# export MANPAGER='nvim -M +Man! -c "set nu"'
# export PAGER='nvim -M +Man! -c "set nonu"'
export MANWIDTH=999
export SAVEHIST=50000 # 履歴ファイルに保存される履歴の件数
export TERM="xterm-256color"
export VISUAL='nvim'

# export CPLUS_INCLUDE_PATH="/Library/Developer/CommandLineTools/SDKs/MacOSX12.sdk/usr/include:/Library/Developer/CommandLineTools/SDKs/MacOSX12.sdk/System/Library/Frameworks"
# export LD_LIBRARY_PATH="/Library/Developer/CommandLineTools/SDKs/MacOSX12.sdk/System/Library/Frameworks"

source $HOME/.dotfiles/zsh/custom_func.zsh
source $HOME/.dotfiles/zsh/template.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# │ {{{                         « PATH »                                  │
# ┼───────────────────────────────────────────────────────────────────────┼


if whence deno > /dev/null ; then
  export PATH="$HOME/.deno/bin:$PATH"
fi
if whence go > /dev/null ; then
  export PATH="$HOME/go/bin/:$PATH"
fi
if whence cargo > /dev/null ; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

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

if whence pyenv > /dev/null ; then
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi

if whence rbenv > /dev/null ; then
  eval "$(rbenv init - zsh)"
fi

if [ -e ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi

if [ -e ~/.zshrc ]; then
  source ~/.zshrc
fi

alias v='nvim'
alias vi='nvim'
alias vv='nvim'

# }}}
# ┼───────────────────────────────────────────────────────────────────────┼
# vim:foldmethod=marker:
