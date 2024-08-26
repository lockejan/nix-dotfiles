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
    com.apple = {
      dock.tilesize = 64;
      Safari.SandboxBroker.ShowDevelopMenu = true;
      Safari.WebKitPreferences.developerExtrasEnabled = true;
      menuextra.battery.ShowPercent = "YES";
      desktopservices.DSDontWriteUSBStores = true;
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
