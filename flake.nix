{
  description = "Machine configurations with nix";

  inputs = {
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
    nixpkgs-nixos.url = "github:NixOs/nixpkgs/nixos-22.11";

    # darwin.url = "github:lnl7/nix-darwin";
    darwin.url = "github:n8henrie/nix-darwin?ref=issue_549";
    darwin.inputs.nixpkgs.follows = "nixpkgs-stable";

    home-manager.url = "github:lockejan/home-manager/ssh-addKeysToAgent";
    # home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs-stable";

    nvim-config = {
      url = "github:lockejan/neovim-config";
      flake = false;
    };
  };

  outputs = { self, home-manager, darwin, ... }@inputs:
    let
      system.work = "x86_64-darwin";
      user.work = "schmitt";
      system.m1 = "aarch64-darwin";
      user.m1 = "lockejan";
      system.raspbi = "aarch64-linux";
      pkgs = import inputs.nixpkgs-stable {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [ inputs.neovim-nightly-overlay.overlay ];
      };
    in
    {

      darwinConfigurations = {
        m1 = darwin.lib.darwinSystem {
          modules = [
            home-manager.darwinModules.home-manager
            ./darwin/configuration.nix
            {
              # `home-manager` config
              # home-manager.useGlobalPkgs = true;
              # home-manager.useUserPackages = true;
              home-manager.users.${user.m1}.imports =
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
                  ./home-manager/modules/ssh.nix
                  ./home-manager/modules/tmux.nix
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
            ./darwin/work-configuration.nix
            {
              # `home-manager` config
              # home-manager.useGlobalPkgs = true;
              # home-manager.useUserPackages = true;
              home-manager.users.${user.work}.imports =
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
                  # ./home-manager/modules/ssh.nix
                  ./home-manager/modules/tmux.nix
                  ./home-manager/machines/work.nix
                ];
              # inherit pkgs;
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
