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
    "lsd"
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
    "echo"
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
    "vi"
    "vim"
    "nvim"
    "tmux"
    "r"
    "dr"
    "git switch"
    "git add *"
    "pytest"
    "open ."
)

export HISTORY_IGNORE=$(IFS="|";echo "${HISTORY_IGNORE_[*]}")

unset HISTORY_IGNORE_
