{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [ gnupg1 pinentry pinentry_mac ];

  programs = { gpg.enable = true; };
}
