{ config, pkgs, ... }:
let
  unstable = pkgs;
  # unstable = import <unstable> {
  #   config.allowUnfree = true;
  # };
in
{

  home.packages = with pkgs; [
    babashka
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
    hexyl
    htop
    hyperfine
    inetutils
    unstable.ijq
    jdk17_headless
    jq
    less
    ncurses
    ncdu
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
    tree-sitter
    vagrant
    watch
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

  home.stateVersion = "22.11";

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  home.file.".ideavimrc".source =
    config.lib.file.mkOutOfStoreSymlink ./configs/idea/ideavimrc;

  home.file.".hammerspoon".source =
    config.lib.file.mkOutOfStoreSymlink ./configs/hammerspoon;
}
