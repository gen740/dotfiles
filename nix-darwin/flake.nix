{
  description = "Gen740's NixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          environment.systemPackages = [
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

          fonts.packages = [ pkgs.fira-code-nerdfont ];

          # Auto upgrade nix package and the daemon service.
          services.nix-daemon.enable = true;
          programs.zsh.enable = true;
          homebrew = {
            enable = true;
            casks = [
              "google-drive"
              "onedrive"
              "notion"
              "notion-calendar"

              "docker"
              "minecraft"
              "xquartz"
            ];
            caskArgs.appdir = "/Applications/Homebrew Apps";
          };

          nix = {
            package = pkgs.nixFlakes;
            settings = {
              experimental-features = "nix-command flakes";
              extra-platforms = "aarch64-darwin";
            };
          };

          system.stateVersion = 4;

          nixpkgs.hostPlatform = "aarch64-darwin";
          nixpkgs.config.allowUnfree = true;
        };
    in
    {
      darwinConfigurations.gen740 = nix-darwin.lib.darwinSystem {
        modules =
          [ configuration ]
          ++ [
            home-manager.darwinModules.home-manager
            (

              { ... }:
              {
                users.users.gen = {
                  name = "gen";
                  home = "/Users/gen";
                };
                home-manager.users.gen = (import ./home.nix);
              }
            )
          ];
      };
      darwinPackages = self.darwinConfigurations.gen740.pkgs;
    };
}
