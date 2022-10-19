{ config, pkgs, ... }:
let
  unstable = import <unstable> {
    config.allowUnfree = true;
  };
in
{

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
      # sha256 = "1iff20vql5iwcjdf20r49v7m0mf1qzi8xwg6qx6yvijgl35ac2z4";
    }))
  ];

  imports = [
    ./modules/alacritty.nix
    # ./modules/osx.nix
    ./modules/cli.nix
    ./modules/git.nix
    ./modules/gpg.nix
    ./modules/kitty.nix
    ./modules/neovim.nix
    ./modules/python.nix
    # ./modules/ssh.nix
    ./modules/tmux.nix
    (if builtins.getEnv "USER" == "schmitt" then
      ./machines/work.nix
    else
      ./machines/personal.nix)
  ];

  home.packages = with pkgs; [
    cachix
    ctop
    curl
    dive
    dockutil
    dogdns
    entr
    fd
    geckodriver
    glances
    gnugrep
    google-java-format
    htop
    hyperfine
    inetutils
    unstable.ijq
    jdk17_headless
    jq
    less
    nix-prefetch-git
    nixpkgs-fmt
    nixpkgs-review
    nix-tree
    nix-update
    niv
    openssl
    pwgen
    ripgrep
    sourceHighlight
    tldr
    trash-cli
    vagrant
    watch
    wget2
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # nixpkgs.config.allowUnfree = true;

  # home.username = builtins.getEnv "USER";
  # home.homeDirectory = builtins.getEnv "HOME";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "$EDITOR";
    # PAGER = "nvim -R";
    # MANPAGER = "nvim +Man!";
    LESS = "-R --use-color Du+b";
    # MANPAGER="less -R --use-color -Dd+r -Du+b";
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#808080";
  };

  home.stateVersion = "22.05";

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  home.file.".ideavimrc".source =
    config.lib.file.mkOutOfStoreSymlink ./configs/idea/ideavimrc;

  home.file.".hammerspoon".source =
    config.lib.file.mkOutOfStoreSymlink ./configs/hammerspoon;
}
