{
  description = "Machine configurations with nix";

  inputs = {
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, home-manager, darwin, ... }@inputs:

    let
      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];
    in
    {
      nixpkgsDefaults = {
        config = {
          allowUnfree = true;
        };
      };

      darwinConfigurations = {

        m1 = darwin.lib.darwinSystem {
          # you can have multiple darwinConfigurations per flake, one per hostname

          modules = [
            home-manager.darwinModules.home-manager
            ./darwin/darwin-configuration.nix
          ];
          system = "aarch64-darwin";
        };

      };
    };
}
