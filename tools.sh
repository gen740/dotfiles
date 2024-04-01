#!/bin/bash

tools=(
  # Utilities
  "tmux"
  "wget"
  "git"
  "curl"

  "direnv"
  "pipx"
  "fd"
  "fzf"
  "gh"
  "glab"
  "lazygit"
  "git-lfs"
  "rustup-init"

  "jq"

  # "neovim"
  # "pre-commit"
  "ripgrep"
  "go-task"

  "qmk/qmk/qmk"

  # node
  "volta"
  "biome"

  # python tools
  "ruff"
  "ruff-lsp"
  "pyright"
  "hatch"

  # build tools
  "cmake"
  "llvm"
  "ninja"
  "clang-format"

  # language servers
  "lua-language-server"
  "typescript-language-server"
  "vscode-langservers-extracted"
  "yaml-language-server"
  "gopls"
  "stylua"
  "texlab"
  "texlive"
  "biber"
  "swift-format"

  # yabai
  "koekeishiya/formulae/skhd"
  "koekeishiya/formulae/yabai"

  # cask
  "--cask docker"
  "--cask skim"
  "--cask notion"
  "--cask notion-calendar"
  "--cask raycast"
  "--cask xquartz"
  "--cask istat-menus"
  "--cask slack"

) # ltspice

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
