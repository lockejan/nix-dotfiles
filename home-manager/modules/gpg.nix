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

  home.file.".gnupg/gpg-agent.conf".text = ''
    # pinentry-program ${pkgs.pinentry}/bin/pinentry
    pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
    default-cache-ttl 600
    max-cache-ttl 7200
  '';

}
