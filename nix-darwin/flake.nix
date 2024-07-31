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

            pkgs.jetbrains.pycharm-professional
            pkgs.jetbrains.clion
            pkgs.jetbrains.dataspell
          ];

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

              "minecraft"
              "steam"
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

          system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
          # system.defaults.universalaccess.reduceMotion = true;
          # system.defaults.universalaccess.reduceTransparency = true;

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
            (import ./home.nix)
          ];
      };
      darwinPackages = self.darwinConfigurations.gen740.pkgs;
    };
}
