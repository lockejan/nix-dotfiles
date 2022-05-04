{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];

  imports = [
    # ./modules/alacritty.nix
    ./modules/osx.nix
    ./modules/cli.nix
    ./modules/git.nix
    ./modules/gpg.nix
    ./modules/kitty.nix
    ./modules/neovim.nix
    ./modules/python.nix
    ./modules/ssh.nix
    ./modules/tmux.nix
    (if builtins.getEnv "USER" == "schmitt" then
      ./machines/work.nix
    else
      ./machines/personal.nix)
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "$EDITOR";
    # PAGER = "nvim -R";
    MANPAGER = "nvim +Man!";
    PATH = "$PATH:/Library/Developer/CommandLineTools/usr/bin/";
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#808080";
  };

  home.packages = with pkgs; [
    cachix
    ctop
    curl
    dive
    dogdns
    entr
    fd
    glances
    gnugrep
    htop
    google-java-format
    hyperfine
    jdk
    jq
    less
    nix
    nixpkgs-fmt
    nixpkgs-review
    nix-tree
    nix-update
    openssl
    pwgen
    ripgrep
    tldr
    trash-cli
    vagrant
    watch
    wget
  ];

  home.stateVersion = "21.11";

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  home.file.".hammerspoon".source =
    config.lib.file.mkOutOfStoreSymlink ./configs/hammerspoon;
}
