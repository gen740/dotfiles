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
    pkgs.zsh
    pkgs.zsh-completions
    pkgs.btop
    pkgs.fd
    pkgs.gh
    pkgs.jq
    pkgs.neovim
    pkgs.ripgrep
    pkgs.trash-cli

    pkgs.nixd
    pkgs.nixfmt-rfc-style
    pkgs.taplo-lsp
    pkgs.vscode-langservers-extracted
    pkgs.bash-language-server

    pkgs.nodejs
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
    tmux = import ./tmux-conf.nix { shell = pkgs.zsh.outPath + "/bin/zsh"; };
    git = import ./git-conf.nix;
    zsh = import ./zsh-conf.nix;
  };
}
