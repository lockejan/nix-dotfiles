{ pkgs, inputs, ... }:
let
  user = "schmitt";
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{

  users.users.schmitt = {
    name = user;
    home = "/Users/${user}";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ unstable.vim pkgs._1password ];

  environment.etc."sudoers.d/000-sudo-touchid" = {
    text = ''
      Defaults pam_service=sudo-touchid
      Defaults pam_login_service=sudo-touchid
    '';
  };

  environment.etc."pam.d/sudo-touchid" = {
    text = ''
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
      auth       sufficient     pam_tid.so
      auth       sufficient     pam_smartcard.so
      auth       required       pam_opendirectory.so
      account    required       pam_permit.so
      password   required       pam_deny.so
      session    required       pam_permit.so
    '';
  };

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
      # "homebrew/cask"
    ];

    brews = [
      "openssh"
    ];

    # whalebrews = [ "whalebrew/wget" ];

    casks = [
      # "alacritty"
      # "blackhole-2ch"
      "brave-browser"
      "coconutbattery"
      "docker"
      "discord"
      "element"
      "firefox"
      "flux"
      "focusrite-control"
      "google-chrome"
      "gpg-suite-no-mail"
      "hammerspoon"
      "itsycal"
      "jetbrains-toolbox"
      "joplin"
      "keycastr"
      "kitty"
      "maccy"
      "owasp-zap"
      "postman"
      # "rancher"
      "rectangle"
      "slack"
      "signal"
      "sequel-ace"
      "spotify"
      "teamviewer"
      "tomighty"
      "visual-studio-code"
      "wireshark"
      "yubico-authenticator"
      "yubico-yubikey-manager"
      # "yubico-piv-tool"
    ];

    masApps = {
      "AdGuard for Safari" = 1440147259;
      # "Slack for Desktop" = 803453959;
      # Xcode = 497799835;
    };

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
    dock.appswitcher-all-displays = true;
    dock.autohide = true;
    # dock.autohide-delay = 0.2;
    dock.mru-spaces = false;
    dock.orientation = "left";
    dock.showhidden = true;
    dock.wvous-bl-corner = 1;
    dock.wvous-br-corner = 1;
    dock.wvous-tl-corner = 2;
    dock.wvous-tr-corner = 1;

    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.GuestEnabled = false;
    loginwindow.autoLoginUser = user;
    # ActivityMonitor.SortDirection = 0;

    NSGlobalDomain.AppleMeasurementUnits = "Centimeters";
    NSGlobalDomain.AppleShowAllExtensions = true;
    # NSGlobalDomain.AppleShowScrollBars = "Always";
    NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
    # NSGlobalDomain.com.apple.mouse.tapBehavior = 1;

    LaunchServices.LSQuarantine = false;

    trackpad.Clicking = true;
    trackpad.TrackpadThreeFingerDrag = false;
  };

  system.keyboard.enableKeyMapping = true;
  system.keyboard.nonUS.remapTilde = true;
  system.keyboard.remapCapsLockToControl = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {

    package = pkgs.nix;

    configureBuildUsers = true;
    gc.user = "root";
    gc.automatic = true;

    settings = {
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
    extraOptions = ''
      auto-optimise-store = true
      gc-keep-derivations = true
      gc-keep-outputs = true
      log-lines = 128
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

    # linux-builder.enable = true;

  };

  nixpkgs.config =
    {
      allowUnfree = true;
    };

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
