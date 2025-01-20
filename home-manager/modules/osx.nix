{ config, pkgs, ... }: {
  targets.darwin.defaults = {
    NSGlobalDomain = {
      AppleLanguages = [ "en" "de" ];
      # AppleLocale = "en_US";
      AppleMetricUnits = true;
      AppleTemperatureUnit = "Celsius";
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = true;
      NSAutomaticDashSubstitutionEnabled = true;
      NSAutomaticCapitalizedEnabled = false;
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
    };

  };
  targets.darwin.search = "Google";
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
