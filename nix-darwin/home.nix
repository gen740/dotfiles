{ ... }:
{
  users.users.gen = {
    name = "gen";
    home = "/Users/gen";
  };
  home-manager.users.gen =
    { ... }:
    {
      home.username = "gen";
      home.homeDirectory = "/Users/gen";
      home.stateVersion = "24.05";
      home.shellAliases = {
        v = "nvim";
        vi = "nvim";
        ls = "ls --color -F";
        gs = "git ps";
        dr = "direnv allow";
      };
      programs = {
        fd.enable = true;
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
        fzf.enable = true;
        gh.enable = true;
        home-manager.enable = true;
        neovim.enable = true;
        ripgrep.enable = true;
        starship = import ./starship-conf.nix;
        jq.enable = true;
        tmux = import ./tmux-conf.nix;
        git = import ./git-conf.nix;
        zsh = import ./zsh-conf.nix;
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
      };
    };
}
