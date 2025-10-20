{
  description = "Machine configurations with nix";

  inputs = {
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-nixos.url = "github:NixOs/nixpkgs/nixos-25.05";
    darwin.url = "github:lnl7/nix-darwin/nix-darwin-25.05";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    flake-utils.url = "github:numtide/flake-utils";

    nix-kubectl-gs.url = "github:swoehrl-mw/nix-kubectl-gs";
  };

  outputs = { self, home-manager, darwin, ... }@inputs:
    let
      system.silicon = "aarch64-darwin";
      user.work = "schmitt";
      user.m1 = "lockejan";
      system.raspbi = "aarch64-linux";
      pkgs = import inputs.nixpkgs {
        system = system.silicon;
        config.allowUnfree = true;
      };
      pkgsUnstable = import inputs.nixpkgs-unstable {
        system = system.silicon;
        config.allowUnfree = true;
      };
      stateVersion = "25.05";

      # Common home-manager modules shared across configurations
      commonHomeModules = [
        ./home-manager/home.nix
        ./home-manager/modules/alacritty.nix
        ./home-manager/modules/cli.nix
        ./home-manager/modules/git.nix
        ./home-manager/modules/gpg.nix
        ./home-manager/modules/kitty.nix
        ./home-manager/modules/k8s.nix
        ./home-manager/modules/neovim.nix
        ./home-manager/modules/python.nix
        ./home-manager/modules/ssh.nix
        ./home-manager/modules/tmux.nix
      ];

      # Common special arguments passed to all home-manager configurations
      commonExtraSpecialArgs = {
        inherit inputs;
        inherit stateVersion;
        inherit pkgsUnstable;
      };
    in
    {

      darwinConfigurations = {
        m1 = darwin.lib.darwinSystem {
          modules = [
            home-manager.darwinModules.home-manager
            ./darwin/configuration.nix
            { nixpkgs.config.allowUnfree = true; }
            {
              home-manager = {
                users.${user.m1}.imports = commonHomeModules ++ [
                  # Machine-specific modules
                  # ./home-manager/modules/osx.nix
                  ./home-manager/machines/personal.nix
                ];
                extraSpecialArgs = commonExtraSpecialArgs // {
                  username = user.m1;
                };
              };
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit pkgsUnstable;
            username = user.m1;
          };
          system = system.silicon;
        };
      };

      homeConfigurations."${user.work}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = commonHomeModules ++ [
          # Machine-specific modules
          ./home-manager/modules/osx.nix
          ./home-manager/machines/work.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = commonExtraSpecialArgs // {
          username = user.work;
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
