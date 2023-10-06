{
  description = "Machine configurations with nix";

  inputs = {
    # nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    nixpkgs-nixos.url = "github:NixOs/nixpkgs/nixos-23.05";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # home-manager.url = "github:lockejan/home-manager/ssh-addKeysToAgent";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    flake-utils.url = "github:numtide/flake-utils";

    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";

    # nvim-config = {
    #   url = "github:lockejan/neovim-config";
    #   flake = false;
    # };
  };

  outputs = { self, home-manager, darwin, ... }@inputs:
    let
      system.work = "aarch64-darwin";
      user.work = "schmitt";
      system.m1 = "aarch64-darwin";
      user.m1 = "lockejan";
      system.raspbi = "aarch64-linux";
      # pkgs = import inputs.nixpkgs {
      #   inherit system;
      #   config = { allowUnfree = true; };
      #   # overlays = [ inputs.neovim-nightly-overlay.overlay ];
      # };
    in
    {

      darwinConfigurations = {
        m1 = darwin.lib.darwinSystem {
          modules = [
            home-manager.darwinModules.home-manager
            (import ./darwin/configuration.nix inputs)
            {
              # `home-manager` config
              # home-manager.useGlobalPkgs = true;
              # home-manager.useUserPackages = true;
              home-manager.users.${user.m1}.imports =
                [
                  (import ./home-manager/home.nix inputs)
                  ./home-manager/modules/alacritty.nix
                  # ./home-manager/modules/osx.nix
                  ./home-manager/modules/cli.nix
                  ./home-manager/modules/git.nix
                  ./home-manager/modules/gpg.nix
                  ./home-manager/modules/kitty.nix
                  (import ./home-manager/modules/neovim.nix inputs)
                  ./home-manager/modules/python.nix
                  ./home-manager/modules/ssh.nix
                  (import ./home-manager/modules/tmux.nix inputs)
                  ./home-manager/machines/personal.nix
                ];
              # inherit pkgs;
            }
          ];
          system = system.m1;
        };

        work = darwin.lib.darwinSystem {
          modules = [
            home-manager.darwinModules.home-manager
            (import ./darwin/work-configuration.nix inputs)
            {
              home-manager.users.${user.work}.imports =
                [
                  (import ./home-manager/home.nix inputs)
                  ./home-manager/modules/alacritty.nix
                  ./home-manager/modules/osx.nix
                  ./home-manager/modules/cli.nix
                  ./home-manager/modules/git.nix
                  ./home-manager/modules/gpg.nix
                  ./home-manager/modules/kitty.nix
                  (import ./home-manager/modules/neovim.nix inputs)
                  ./home-manager/modules/python.nix
                  (import ./home-manager/modules/tmux.nix inputs)
                  ./home-manager/machines/work.nix
                ];
            }
          ];
          system = system.work;
        };
      };

      nixosConfigurations = {
        nixos-raspbi = inputs.nixpkgs-nixos.lib.nixosSystem {
          system = system.raspbi;
          modules = [
            ./nixos/configuration.nix
            inputs.nixos-hardware.nixosModules.raspberry-pi-4
          ];
        };
      };

    };
}
