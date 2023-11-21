export HISTSIZE=5000         # メモリに保存される履歴の件数
export SAVEHIST=100000       # 履歴ファイルに保存される履歴の件数
setopt HIST_IGNORE_ALL_DUPS  # Duplicated commands is ignored
setopt HIST_IGNORE_DUPS      # Duplicated commands is ignored
setopt HIST_IGNORE_SPACE     # Command which start with whitespace is ignored
setopt EXTENDED_HISTORY      # Record timestamp
setopt SHARE_HISTORY         # Share History among ttys

HISTORY_IGNORE_=(
    "ls"
    "ls *"
    "l"
    "l *"
    "s"
    "s *"
    "la"
    "la *"
    "ll"
    "ll *"
    "sl"
    "cd"
    "cd *"
    "cd"
    "h"
    "history"
    "exit"
    "popd"
    "pushd"
    "t"
    "v"
    "vi"
    "vim"
    "nvim"
    "v"
    "v *"
    "vi"
    "vi *"
    "vim"
    "vim *"
    "nvim"
    "nvim *"
    "tmux"
    "r"
    "git switch"
    "git add *"
    "pytest"
    "open ."
    "rm *"
)

function zshaddhistory() {
    local words=(${(z)1})
    local cmd=$words[1]
    whence $cmd > /dev/null && return 0 || return 1
}

export HISTORY_IGNORE=$(IFS="|";echo "${HISTORY_IGNORE_[*]}")

unset HISTORY_IGNORE_
