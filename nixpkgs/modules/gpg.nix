{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [ gnupg1 pinentry pinentry_mac ];
  # xdg.configfile.".ssh/config".source = ../configs/ssh/ssh_config;

  programs = { gpg.enable = true; };

}
