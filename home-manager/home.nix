{ config, pkgs, inputs, username, stateVersion, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
  kubectl-gs = inputs.nix-kubectl-gs.packages.${pkgs.system}.kubectl-gs;
  user = username;
in
{

  # home.username = builtins.getEnv "USER";
  # home.homeDirectory = builtins.getEnv "HOME";
  home.username = user;
  home.homeDirectory = "/Users/${user}";

  home.stateVersion = stateVersion;

  home.packages = with pkgs; [
    unstable.act
    babashka
    cachix
    ctop
    curl
    unstable.coreutils-full
    dive
    dockutil
    dogdns
    entr
    exif
    fd
    fluxcd
    fzf-git-sh
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
    unstable.kubectl
    kubectl-gs
    unstable.kubecolor
    unstable.kubernetes-helm
    unstable.krew
    less
    mob
    ncurses
    # ncdu
    # nix-doc
    nix-prefetch-git
    nixpkgs-fmt
    nixpkgs-review
    nix-tree
    nix-update
    niv
    openssl
    # page
    pwgen
    ripgrep
    # solo2-cli
    sourceHighlight
    tldr
    trash-cli
    tree-sitter
    # vagrant
    watch
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "$EDITOR";
    # PAGER = "nvim -R";
    # MANPAGER = "nvim +Man!";
    LESS = "-R --use-color Du+b";
    # MANPAGER="less -R --use-color -Dd+r -Du+b";
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#808080";
    # FZF_CTRL_T_OPTS = "--preview 'bat --color=always --style=numbers --line-range=:500 {}'";
  };


  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  home.file.".ideavimrc".source =
    config.lib.file.mkOutOfStoreSymlink ./configs/idea/ideavimrc;

  home.file.".hammerspoon".source =
    config.lib.file.mkOutOfStoreSymlink ./configs/hammerspoon;
}
