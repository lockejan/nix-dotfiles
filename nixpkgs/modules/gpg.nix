{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    gnupg1
    pinentry
    gpg-tui
    # pinentry_mac
    yubikey-manager
  ];

  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      # reader-port = "Yubico Yubi";
      disable-ccid = true;
      # pcsc-shared = true;
    };
  };
}
