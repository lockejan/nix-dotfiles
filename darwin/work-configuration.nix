{ config, pkgs, ... }:
{

  users.users.schmitt = {
    name = "schmitt";
    home = "/Users/schmitt";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ vim ];

  documentation.enable = false;

  homebrew = {
    enable = true;
    onActivation =
      {
        autoUpdate = false;
        cleanup = "zap";
        upgrade = true;
      };
    taps = [
      "homebrew/cask" # "homebrew/cask-fonts"
      "homebrew/cask-drivers"
    ];

    brews = [ "ykman" "pam-reattach" "openssh" "podman" ];

    # whalebrews = [ "whalebrew/wget" ];

    casks = [
      "1password"
      "alacritty"
      "brave-browser"
      "coconutbattery"
      "docker"
      "firefox"
      "flux"
      "gather"
      "google-chrome"
      "gpg-suite-no-mail"
      "hammerspoon"
      "iterm2"
      "itsycal"
      "jetbrains-toolbox"
      "joplin"
      "keycastr"
      "kitty"
      "logitech-options"
      "mimestream"
      "miro"
      "owasp-zap"
      "postman"
      "rectangle"
      "soapui"
      "spotify"
      "teamviewer"
      "tomighty"
      "virtualbox"
      "visual-studio-code"
      "wireshark"
      "yippy"
      "yubico-authenticator"
      "yubico-yubikey-manager"
      # "yubico-piv-tool"
    ];
  };

  # https://github.com/nix-community/home-manager/issues/423
  # environment.variables = {
  #   TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  # };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  networking.hostName = "smittie-at-sipgate";

  system.defaults = {
    dock.appswitcher-all-displays = false;
    dock.autohide = true;
    # dock.autohide-delay = 0.2;
    dock.mru-spaces = false;
    dock.orientation = "left";
    dock.showhidden = true;
    dock.wvous-bl-corner = 1;
    dock.wvous-br-corner = 1;
    dock.wvous-tl-corner = 1;
    dock.wvous-tr-corner = 1;

    trackpad.Clicking = true;
    trackpad.TrackpadThreeFingerDrag = false;
  };

  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.ShowStatusBar = true;
  system.defaults.loginwindow.GuestEnabled = false;
  system.defaults.loginwindow.autoLoginUser = "schmitt";
  # system.defaults.ActivityMonitor.SortDirection = 0;

  system.defaults.NSGlobalDomain.AppleMeasurementUnits = "Centimeters";
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  # system.defaults.NSGlobalDomain.AppleShowScrollBars = "Always";
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
  # system.defaults.NSGlobalDomain.com.apple.mouse.tapBehavior = 1;

  system.defaults.LaunchServices.LSQuarantine = false;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.nonUS.remapTilde = true;
  system.keyboard.remapCapsLockToControl = true;

  security.pam.enableSudoTouchIdAuth = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.configureBuildUsers = true;

  nix.settings = {
    trusted-users = [ "@admin" ];
    sandbox = true;
    extra-sandbox-paths = [ "/private/tmp" "/private/var/tmp" "/usr/bin/env" ];

    substituters = [
      # "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      # "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # # Enable experimental nix command and flakes
  nix.extraOptions = ''
    # auto-optimise-store = true
    experimental-features = nix-command flakes
    gc-keep-derivations = true
    gc-keep-outputs = true
    log-lines = 128
  '';

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (self: super: {
      openssh = super.openssh.override {
        hpnSupport = true;
        withKerberos = true;
        kerberos = self.libkrb5;
      };
    })
  ];

  # Fonts
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    recursive
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    enableBashCompletion = false;
    promptInit = "";
  };
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

}
