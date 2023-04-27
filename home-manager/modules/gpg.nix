{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    gnupg1
    gpg-tui
    # pinentry
    # pinentry_mac
    yubikey-manager
  ];

  programs.gpg = {
    enable = true;
  };

}
