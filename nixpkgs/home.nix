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

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
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
    ansible
    cachix
    ctop
    curl
    dogdns
    entr
    fd
    glances
    gnugrep
    htop
    hyperfine
    jdk
    jbang
    jq
    less
    ninja
    nix
    nix-tree
    openssl
    podman
    pwgen
    ripgrep
    tldr
    trash-cli
    vagrant
    wget
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  home.file.".hammerspoon".source =
    config.lib.file.mkOutOfStoreSymlink ./configs/hammerspoon;

  home.file.".ghci".text = ''
    :set prompt "\ESC[1;35m\x03BB> \ESC[m"
    :set prompt-cont "\ESC[1;35m > \ESC[m"
    :set +t
  '';
}
