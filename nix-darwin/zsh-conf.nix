{
  initExtraBeforeCompInit = ''
    export FPATH="$FPATH:$HOME/.dotfiles/zsh"
    setopt AUTO_LIST # Automatically list choices on an ambiguous completion.
  '';
  initExtra = ''
    function h() {
        if [ -e $HOME/home ]; then
            dirname=`fd -c never -E .git . $HOME/home/ -aH --type d | fzf`
        else
            dirname=`fd -c never -E .git . $HOME/ -aH --type d | fzf`
        fi

        if [[ $dirname == ""  ]]; then
            return 1
        fi
        pushd $dirname > /dev/null
        unset dirname
    }

    function nix-search() {
        nix search nixpkgs "$1" 2> /dev/null | sed -r 's/\x1B\[[0-9;]*[mG]//g' | grep "^* " | fzf
    }

    function darwin-reload() {
        darwin-rebuild switch --flake ~/.dotfiles/nix-darwin
    }

    stty stop undef # do not stop the terminal with C-s

    bindkey -e

    if [ "$1" != "--no-tmux" ]; then
        whence tmux > /dev/null && [[ -z $TMUX && -z $NVIM ]] && (tmux attach || tmux new -s Main)
    fi
  '';
  sessionVariables = {
    LSCOLORS = "Bxhxcxdxbxexexaxaxaxax";
    FZF_DEFAULT_OPTS = "--border=none --height=24 --scroll-off=3 --no-mouse --prompt=\  --pointer=\ ";
    FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git";
    WORDCHARS = "!$%";
    REPORTTIME = 10;
    TIMEFMT = "%*E %*U %*S CPU: %P Memory: %M KB # %J";
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
    LANG = "en_US.UTF-8";
    LESSCHARSET = "utf-8";
    MANWIDTH = 100;
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
    PAGER = "less";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
  };
  enable = true;
  history = {
    save = 100000;
    size = 10000;
    extended = true;
    expireDuplicatesFirst = true;
    ignoreAllDups = true;
    ignoreDups = true;
    share = true;
    ignoreSpace = true;
    ignorePatterns = [ "rm *" ];
  };
}
