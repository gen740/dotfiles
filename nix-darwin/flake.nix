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
            pkgs.curl
            pkgs.wget

            pkgs.raycast
            pkgs.skimpdf
            pkgs.zoom-us
            pkgs.slack
            pkgs.discord

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
              "google-chrome"
              "google-drive"
              "onedrive"
              "notion"
              "notion-calendar"

              "docker"
              "saoimageds9"
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
              sandbox = true;
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

              { config, pkgs, ... }:
              {
                users.users.gen = {
                  name = "gen";
                  home = "/Users/gen";
                };
                home-manager.users.gen = (
                  import ./home.nix {
                    config = config;
                    pkgs = pkgs;
                    name = "gen";
                    home = "/Users/gen";
                  }
                );
              }
            )
          ];
      };
      darwinPackages = self.darwinConfigurations.gen740.pkgs;
    };
}
