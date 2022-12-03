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
      machines = {
        "personal" = { user = "lockejan"; arch = "aarch64-darwin"; };
        "work" = { user = "schmitt"; arch = "x86_64-darwin"; };
      };
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
          modules = [
            home-manager.darwinModules.home-manager
            ./darwin/darwin-configuration.nix
            {
              # nixpkgs = nixpkgsConfig;
              # `home-manager` config
              # home-manager.useGlobalPkgs = true;
              # home-manager.useUserPackages = true;
              home-manager.users.${machines.personal.user}.imports =
                [
                  ./home-manager/home.nix
                  ./home-manager/modules/alacritty.nix
                  # ./home-manager/modules/osx.nix
                  ./home-manager/modules/cli.nix
                  ./home-manager/modules/git.nix
                  ./home-manager/modules/gpg.nix
                  ./home-manager/modules/kitty.nix
                  ./home-manager/modules/neovim.nix
                  ./home-manager/modules/python.nix
                  #./home-manager/modules/ssh.nix
                  ./home-manager/modules/tmux.nix
                  # (if user == "lockejan" then
                  ./home-manager/machines/personal.nix
                  # else
                  # ./home-manager/machines/work.nix
                  # )
                ];
            }
          ];
          system = machines.personal.arch;
        };

      };
    };
}
