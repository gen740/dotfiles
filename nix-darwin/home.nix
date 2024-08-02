{
  config,
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
    v = "nvim";
    vi = "nvim";
    ls = "ls --color -F";
    gs = "git ps";
    dr = "direnv allow";
  };

  home.packages = [
    pkgs.coreutils

    pkgs.zsh-completions
    pkgs.btop
    pkgs.fd
    pkgs.gh
    pkgs.jq
    pkgs.curl
    pkgs.wget
    pkgs.neovim
    pkgs.ripgrep
    pkgs.trash-cli

    pkgs.nixd
    pkgs.nixfmt-rfc-style
    pkgs.taplo-lsp
    pkgs.vscode-langservers-extracted

    pkgs.raycast
    pkgs.skimpdf
    pkgs.zoom-us
    pkgs.slack

    pkgs.nodejs

    pkgs.jetbrains.pycharm-professional
    pkgs.jetbrains.clion
    pkgs.jetbrains.dataspell
  ];
  programs = {
    home-manager.enable = true;
    alacritty = {
      enable = true;
      settings = {
        import = [
          "~/.dotfiles/alacritty/theme.toml"
          "~/.dotfiles/alacritty/keybindings.toml"
        ];
        font.size = 14;
        font.normal.family = "FiraCode Nerd Font";
        window = {
          decorations = "none";
          option_as_alt = "Both";
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
    tmux = import ./tmux-conf.nix;
    git = import ./git-conf.nix;
    zsh = import ./zsh-conf.nix;
  };
}
