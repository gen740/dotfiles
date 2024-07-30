{
  description = "Gen740's NixOS configuration";
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };
  outputs =
    {
      self,
      nix-darwin,
      nixpkgs-unstable,
      home-manager,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          environment.systemPackages = [
            pkgs.vscode-langservers-extracted
            pkgs.nixd
            pkgs.nixfmt-rfc-style
            pkgs.btop
            pkgs.trash-cli
          ];

          # Auto upgrade nix package and the daemon service.
          services.nix-daemon.enable = true;
          programs.zsh.enable = true;

          nix = {
            package = pkgs.nixFlakes;
            settings = {
              experimental-features = "nix-command flakes";
              extra-platforms = "aarch64-darwin";
            };
          };

          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 4;
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      darwinConfigurations.gen740 = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          (import ./home.nix)
        ];
      };
      darwinPackages = self.darwinConfigurations.gen740.pkgs;
    };
}
