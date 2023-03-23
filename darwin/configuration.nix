{ nixpkgs-unstable, ... }:
{ config, pkgs, lib, ... }:
let
  user = "lockejan";
  unstable = nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  users.users."${user}" = {
    name = "${user}";
    home = "/Users/${user}";
    shell = pkgs.zsh;
  };

  # home-manager.backupFileExtension = "bak";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ unstable.vim ];
  # environment.shells = [ pkgs.zsh ];

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

  homebrew = {
    enable = true;
    # global.autoUpdate = false;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
      upgrade = true;
    };
    taps = [
      "homebrew/cask"
      # "homebrew/cask-fonts"
      "homebrew/cask-drivers"
    ];

    brews = [ "pinentry-mac" ];

    # whalebrews = [ "whalebrew/wget" ];

    casks = [
      "anki"
      "alacritty"
      "authy"
      "brave-browser"
      "breitbandmessung"
      "coconutbattery"
      "docker"
      "electrum"
      "element"
      "emacs"
      "firefox"
      "flux"
      "focusrite-control"
      "google-chrome"
      "hammerspoon"
      "itsycal"
      "iterm2"
      "jetbrains-toolbox"
      "joplin"
      "keycastr"
      "kitty"
      # "logitech-options"
      "maccy"
      "microsoft-teams"
      "nextcloud"
      "owasp-zap"
      "raspberry-pi-imager"
      "rectangle"
      "signal"
      "spotify"
      "teamviewer"
      "telegram-desktop"
      "tomighty"
      "tor-browser"
      "utm"
      "visual-studio-code"
      # "whatsapp"
      "wireshark"
      "zoom"
      # "postman"
    ];

    masApps = {
      "AdGuard for Safari" = 1440147259;
      Bitwarden = 1352778147;
      iMovie = 408981434;
      "irealb Pro" = 409035833;
      Keynote = 409183694;
      Kindle = 405399194;
      "Logic Pro" = 634148309;
      Mactracker = 430255202;
      Numbers = 409203825;
      # Pages = 409201541;
      "Slack for Desktop" = 803453959;
      # Xcode = 497799835;
    };

  };

  networking.hostName = "${user}-machine";

  # programs.gnupg.agent.enable = true;
  # programs.gnupg.agent.enableSSHSupport = true;

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
  system.defaults.loginwindow.autoLoginUser = "${user}";
  # system.defaults.ActivityMonitor.SortDirection = 0;

  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

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

  # Add ability to used TouchID for sudo authentication
  # security.pam.enableSudoTouchIdAuth = true;
  # security.pam.enablePamReattach = true;

  # environment.etc."DefaultKeyBinding.dict".text = ''
  #   {
  #     "~f"    = "moveWordForward:";
  #     "~b"    = "moveWordBackward:";
  #     "~d"    = "deleteWordForward:";
  #     "~^h"   = "deleteWordBackward:";
  #     "~\010" = "deleteWordBackward:";    /* Option-backspace */
  #     "~\177" = "deleteWordBackward:";    /* Option-delete */
  #     "~v"    = "pageUp:";
  #     "^v"    = "pageDown:";
  #     "~<"    = "moveToBeginningOfDocument:";
  #     "~>"    = "moveToEndOfDocument:";
  #     "^/"    = "undo:";
  #     "~/"    = "complete:";
  #     "^g"    = "_cancelKey:";
  #     "^a"    = "moveToBeginningOfLine:";
  #     "^e"    = "moveToEndOfLine:";
  #     "~c"    = "capitalizeWord:"; /* M-c */
  #     "~u"    = "uppercaseWord:";   /* M-u */
  #     "~l"    = "lowercaseWord:";   /* M-l */
  #     "^t"    = "transpose:";      /* C-t */
  #     "~t"    = "transposeWords:"; /* M-t */
  #   }
  # '';

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.configureBuildUsers = true;

  nix.settings = {
    sandbox = true;
    trusted-users = [ "@admin" ];
    extra-sandbox-paths = [ "/private/tmp" "/private/var/tmp" "/usr/bin/env" ];
    substituters = [ "https://nix-community.cachix.org" "https://lockejan-nur.cachix.org" ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "lockejan-nur.cachix.org-1:xRzsQG4xTHMx7piti7DD6iwu+bR7pdeAJEd5VwdZCv4="
    ];

  };

  # # Enable experimental nix command and flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
    gc-keep-derivations = true
    gc-keep-outputs = true
    log-lines = 128
    # auto-optimise-store = true
  '';

  # programs.nix-index.enable = true;
  nixpkgs.config.allowUnfree = true;

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
