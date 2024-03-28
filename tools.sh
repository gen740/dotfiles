#!/bin/bash

tools=(
  # Utilities
  "tmux"
  "tokei"
  "direnv"
  "pipx"
  "fd"
  "fzf"
  "gh"
  "glab"
  "lazygit"
  "git-lfs"
  "rust"
  "rust-analyzer"
  "rustfmt"
  "wget"
  "git"
  "curl"

  "jq"
  "lsd"

  # "neovim"
  "pre-commit"
  "ripgrep"
  "go-task"
  "prettier"

  "qmk/qmk/qmk"

  # node
  "nodenv"
  "biome"

  # python tools
  "ruff"
  "ruff-lsp"
  "pyright"
  "rye"
  "uv"

  # build tools
  "cmake"
  "llvm"
  "clang-format"
  "ninja"

  # language servers
  "lua-language-server"
  "typescript-language-server"
  "vscode-langservers-extracted"
  "yaml-language-server"
  "gopls"
  "taplo"
  "stylua"
  "texlab"
  "texlive"
  "biber"
  "swift-format"

  # yabai
  "koekeishiya/formulae/skhd --HEAD"
  "koekeishiya/formulae/yabai --HEAD"

  # cask
  "--cask docker"
  "--cask skim"
)

bar_size=40
bar_char_done="#"
bar_char_todo="-"
bar_percentage_scale=2

function show_progress {
    current="$1"
    total="$2"

    # calculate the progress in percentage 
    percent=$(bc <<< "scale=$bar_percentage_scale; 100 * $current / $total" )
    # The number of done and todo characters
    done=$(bc <<< "scale=0; $bar_size * $percent / 100" )
    todo=$(bc <<< "scale=0; $bar_size - $done" )

    # build the done and todo sub-bars
    done_sub_bar=$(printf "%${done}s" | tr " " "${bar_char_done}")
    todo_sub_bar=$(printf "%${todo}s" | tr " " "${bar_char_todo}")

    # output the bar
    echo -ne "\rProgress : [${done_sub_bar}${todo_sub_bar}] ${percent}%"

    if [ $total -eq $current ]; then
        echo -e "\nDONE"
    fi
}

for (( i = 0; i < ${#tools[@]}; i++ )); do
  brew install -q --force ${tools[$i]}
  show_progress $(($i+1)) ${#tools[@]}
done
