{ config, pkgs, lib, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  users.users.lockejan = {
    name = "lockejan";
    home = "/Users/lockejan";
    shell = pkgs.zsh;
  };

  home-manager = {
    # useUserPackages = true;
    # useGlobalPkgs = true;
    users.lockejan = import ../dotfiles/home-manager/home.nix;
  };

  # https://github.com/nix-community/home-manager/issues/423
  environment.variables = {
    TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  };

  # programs.gnupg.agent.enable = true;
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ vim ];
  environment.shells = [ pkgs.zsh ];

  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    taps = [
      "homebrew/cask" # "homebrew/cask-fonts"
      "homebrew/cask-drivers"
    ];

    brews = [ "pinentry-mac" "pam-reattach" ];

    # whalebrews = [ "whalebrew/wget" ];

    casks = [
      "anki"
      "authy"
      "brave-browser"
      "breitbandmessung"
      "coconutbattery"
      "docker"
      "electrum"
      "element"
      "firefox"
      "flux"
      "hammerspoon"
      "itsycal"
      "iterm2"
      "jetbrains-toolbox"
      "joplin"
      "keycastr"
      "kitty"
      "logitech-options"
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
      "visual-studio-code"
      "wireshark"
      "yippy"
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

  networking.hostName = "lockejan-machine";

  # programs.gnupg.agent.enable = true;
  # programs.gnupg.agent.enableSSHSupport = true;

  system.defaults = {
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
  system.defaults.loginwindow.autoLoginUser = "lockejan";
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
  #     "~c"	  = "capitalizeWord:"; /* M-c */
  #     "~u"	  = "uppercaseWord:";	 /* M-u */
  #     "~l"	  = "lowercaseWord:";	 /* M-l */
  #     "^t"	  = "transpose:";      /* C-t */
  #     "~t"	  = "transposeWords:"; /* M-t */
  #   }
  # '';

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.binaryCaches = [ # "https://cache.nixos.org/"
    "https://nix-community.cachix.org"
  ];

  nix.binaryCachePublicKeys = [
    # "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
  nix.trustedUsers = [ "@admin" ];
  users.nix.configureBuildUsers = true;

  # # Enable experimental nix command and flakes
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
    gc-keep-derivations = true
    gc-keep-outputs = true
  '';

  # programs.nix-index.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    recursive
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Add ability to used TouchID for sudo authentication
  # security.pam.enableSudoTouchIdAuth = true;

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
