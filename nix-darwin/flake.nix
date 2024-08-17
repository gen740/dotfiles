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
      nix-darwin-config =
        { pkgs, ... }:
        {
          environment.systemPackages = [
            pkgs.coreutils
            pkgs.curl
            pkgs.wget
          ];
          fonts.packages = [ pkgs.fira-code-nerdfont ];
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
              "raycast"
              "slack"
              "discord"
              "zoom"
              "skim"
              "docker"
              "minecraft"
              "xquartz"
            ];
            caskArgs.appdir = "/Applications/Homebrew Apps";
          };
          nix = {
            package = pkgs.nix;
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
      home-manager-config =
        { pkgs, ... }:
        {
          users.users.gen = {
            name = "gen";
            home = "/Users/gen";
          };
          home-manager.users.gen = (
            import ./home.nix {
              pkgs = pkgs;
              name = "gen";
              home = "/Users/gen";
            }
          );
        };
    in
    {
      darwinConfigurations.gen740 = nix-darwin.lib.darwinSystem {
        modules = [
          nix-darwin-config
          home-manager.darwinModules.home-manager
          home-manager-config
        ];
      };
      darwinPackages = self.darwinConfigurations.gen740.pkgs;
    };
}
