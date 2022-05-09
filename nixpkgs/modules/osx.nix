{ config, pkgs, libs, ... }: {
  targets.darwin.defaults = {
    NSGlobalDomain = {
      AppleLanguages = [ "en" "de" ];
      AppleLocale = "en_US";
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
      # menuextra.battery.ShowPercent = "YES";
      desktopservices.DSDontWriteUSBStores = true;
      LaunchServices = false;
    };

  };
  targets.darwin.search = "Google";
  # targets.darwin.keybindings = {
  #   "^u" = "deleteToBeginningOfLine:";
  #   "^w" = "deleteWordBackward:";
  # };
}
