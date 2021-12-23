{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    gnupg1
    pinentry
    pinentry_mac
    yubikey-manager
    yubikey-agent
  ];

  programs = { gpg.enable = true; };
}
