{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    gnupg1
    pinentry
    gpg-tui
    # pinentry_mac
    # yubikey-manager
  ];

}
