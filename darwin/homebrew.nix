{ ... }:
{
  homebrew = {
    enable = true;
    # global.autoUpdate = false;
    global.brewfile = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
      upgrade = true;
    };
    taps = [
      # "homebrew/cask"
      # "clojure-lsp/brew"
      # "zkondor/dist"
    ];

    brews = [
      # "clojure-lsp-native"
      "azure-cli"
      "ansible-language-server"
    ];

    # whalebrews = [ "whalebrew/wget" ];

    casks = [
      "anki"
      "asana"
      "brave-browser"
      # "breitbandmessung"
      "calibre"
      "cursor"
      # "docker"
      "dotnet-sdk"
      "electrum"
      "element"
      "firefox"
      # "flux"
      "focusrite-control"
      # "google-chrome"
      # "hammerspoon"
      "hiddenbar"
      "insomnia"
      "itsycal"
      "iterm2"
      "jetbrains-toolbox"
      "joplin"
      "kitty"
      "maccy"
      "microsoft-auto-update"
      "microsoft-teams"
      "microsoft-outlook"
      "monitorcontrol"
      "nextcloud"
      # "obsidian"
      # "postman"
      "portfolioperformance"
      "rectangle"
      "signal"
      # "sonos"
      # "spotify"
      "stats"
      "teamviewer"
      # "telegram-desktop"
      "tomighty"
      "utm"
      "visual-studio-code"
      "vlc"
      "whatsapp"
      "wireshark-app"
      "yubico-authenticator"
      "yubico-yubikey-manager"
      "zap"
      # "znotch"
      # "alacritty"
      # "coconutbattery"
      # "emacs"
      # "espanso"
      # "iterm2"
      # "keycastr"
      # "logitech-options"
      # "rancher"
      # "raspberry-pi-imager"
      # "raycast"
      # "tor-browser"
      # "zoom"
    ];

    masApps = {
      "AdGuard for Safari" = 1440147259;
      "AusweisApp Bund" = 948660805;
      Bitwarden = 1352778147;
      iMovie = 408981434;
      "irealb Pro" = 409035833;
      Keynote = 409183694;
      Kindle = 302584613;
      "Logic Pro" = 634148309;
      Mactracker = 430255202;
      Numbers = 409203825;
      # Pages = 409201541;
      "Slack for Desktop" = 803453959;
      "WireGuard" = 1451685025;
      # Xcode = 497799835;
    };
  };
}
