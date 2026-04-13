{ config, lib, pkgs, ... }: {
  targets.darwin.defaults = {
    NSGlobalDomain = {
      AppleLanguages = [ "en" "de" ];
      # AppleLocale = "en_US";
      # AppleInterfaceStyle = "Dark";
      AppleMeasurementUnits = "Centimeters";
      AppleTemperatureUnit = "Celsius";
      AppleShowAllExtensions = true;
      # AppleShowScrollBars = "Always";
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = true;
      NSAutomaticDashSubstitutionEnabled = true;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSNavPanelExpandedStateForSaveMode = true;
      PMPrintingExpandedStateForPrint = true;
      "com.apple.mouse.tapBehavior" = 1;
    };
    "com.apple.Safari" = {
      SandboxBroker.ShowDevelopMenu = true;
      WebKitPreferences.developerExtrasEnabled = true;
    };
    "com.apple.desktopservices" = {
      DSDontWriteUSBStores = true;
    };
    "com.apple.dock" = {
      autohide = true;
      tilesize = 32;
      orientation = "left";
      appswitcher-all-displays = true;
      mru-spaces = false;
      showhidden = true;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 2;
      wvous-tr-corner = 1;
    };
    "com.apple.finder" = {
      ShowStatusBar = true;
      ShowPathbar = true;
      FXPreferredViewStyle = "clmv";
    };
    "com.apple.LaunchServices" = {
      LSQuarantine = false;
    };
    "com.apple.driver.AppleBluetoothMultitouch.trackpad" = {
      Clicking = true;
      TrackpadThreeFingerDrag = false;
    };
    "com.apple.AppleMultitouchTrackpad" = {
      Clicking = true;
      TrackpadThreeFingerDrag = false;
    };
  };
  targets.darwin.search = "Google";

  home.activation.restartDock = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    /usr/bin/killall Dock || true
  '';

  launchd.agents.dotfiles-update = {
    enable = true;
    config = {
      ProgramArguments = [
        "/bin/zsh"
        "-l"
        "-c"
        ''cd ~/dotfiles && output=$(git pull) && if echo "$output" | grep -qv "Already up to date"; then /usr/bin/osascript -e 'display notification "New dotfiles changes pulled. Run drs to rebuild." with title "Dotfiles Updated"'; fi''
      ];
      StartCalendarInterval = [{ Hour = 9; Minute = 0; }];
      StandardOutPath = "/tmp/dotfiles-update.log";
      StandardErrorPath = "/tmp/dotfiles-update.err";
    };
  };
  # targets.darwin.keybindings = {
  #   "^u" = "deleteToBeginningOfLine:";
  #   "^w" = "deleteWordBackward:";
  # };

  #   home.file."Library/Keyboard Layouts/EurKEY.icns".source =
  #     config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager/configs/KeyboardLayouts/EurKEY.icns";
  #
  #   home.file."Library/Keyboard Layouts/EurKEY.keylayout".source =
  #     config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager/configs/KeyboardLayouts/EurKEY.keylayout";
}
