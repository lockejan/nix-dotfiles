{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  imports = [
    ./modules/cli.nix
    ./modules/ssh.nix
    ./modules/gpg.nix
    ./modules/alacritty.nix
    ./modules/kitty.nix
    ./modules/neovim.nix
    ./modules/git.nix
    ./modules/python.nix
    ./modules/tmux.nix
    ./modules/work.nix
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
    coreutils-full
    curl
    diff-so-fancy
    entr
    fd
    gnugrep
    htop
    jq
    less
    ninja
    openssl
    podman
    pwgen
    ripgrep
    tldr
    trash-cli
    tree
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

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';
}
