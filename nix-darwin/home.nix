{
  pkgs,
  name,
  home,
  ...
}:
{
  home.username = name;
  home.homeDirectory = home;
  home.stateVersion = "24.05";
  home.shellAliases = {
    ls = "ls --color -F";
    dr = "direnv allow";
    ta = "tmux attach";
  };
  home.packages = with pkgs; [
    zsh
    zsh-completions
    btop
    fd
    ripgrep
    gh
    glab
    jq
    trash-cli
    nixd
    nixfmt-rfc-style
    taplo-lsp
    vscode-langservers-extracted
    bash-language-server
    nodejs
    tokei
  ];
  programs = {
    home-manager.enable = true;
    gpg = {
      enable = true;
      homedir = "${home}/.gnupg";
    };
    alacritty = {
      enable = true;
      settings = {
        general.import = [
          "~/.dotfiles/alacritty/theme.toml"
          "~/.dotfiles/alacritty/keybindings.toml"
        ];
        font.size = 14;
        font.normal.family = "FiraCode Nerd Font";
        window = {
          decorations = "none";
          option_as_alt = "Both";
          startup_mode = "Maximized";
          padding = {
            x = 10;
            y = 10;
          };
        };
      };
    };
    fzf = {
      enable = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      defaultOptions = [
        "--border=none"
        "--height=24"
        "--scroll-off=3"
        "--no-mouse"
        "--prompt=\ "
        "--pointer=\ "
      ];
    };
    lazygit = {
      enable = true;
      settings = {
        gui = {
          border = "single";
          nerdFontsVersion = "3";
          showBottomLine = false;
        };
      };
    };
    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    starship = import ./starship-conf.nix;
    tmux = import ./tmux-conf.nix { shell = pkgs.zsh.outPath + "/bin/zsh"; };
    git = import ./git-conf.nix;
    zsh = import ./zsh-conf.nix;
    neovim = import ./neovim.nix { inherit pkgs; };
  };
}
