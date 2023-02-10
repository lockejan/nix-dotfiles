{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    gnupg1
    pinentry
    gpg-tui
    yubikey-manager
    # pinentry_mac
  ];

  programs.gpg = {
    enable = true;
  };

}
