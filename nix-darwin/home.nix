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
        fzf.enable = true;
        gh.enable = true;
        home-manager.enable = true;
        neovim.enable = true;
        ripgrep.enable = true;
        starship.enable = true;
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
