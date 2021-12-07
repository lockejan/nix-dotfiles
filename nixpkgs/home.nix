{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  imports = [
    ./modules/cli.nix
    /* ./gpg.nix */
    ./modules/ssh.nix
    ./modules/alacritty.nix
    ./modules/neovim.nix
    ./modules/git.nix
    ./modules/python.nix
    ./modules/tmux.nix
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
    ANSIBLE_VAULT_PASSWORD_FILE = "$HOME/ansible-vault.sh";
    PATH = "$PATH:/Library/Developer/CommandLineTools/usr/bin/";
  };

  home.packages = with pkgs; [
    ansible
    /* ansible-lint */
    curl
    coreutils-full
    diff-so-fancy
    entr
    extract_url
    fd
    gnupg1
    gnugrep
    gopass
    htop
    hugo
    ipcalc
    less
    jq
    jdk11
    keychain
    lua
    nodejs
    nodePackages.typescript
    /* nerdfonts */
    ninja
    /* nix-zsh-completions */
    nixpkgs-fmt
    stylua
    yapf
    openssl
    podman
    pinentry
    pinentry_mac
    /* podman-compose */
    ripgrep
    tldr
    tree
    trash-cli
    vagrant
    yarn
  ];

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "OneHalfDark";
      italic-text = "always";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';
}
