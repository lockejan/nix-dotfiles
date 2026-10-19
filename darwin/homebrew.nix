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
      # "azure-cli" # via nix: home-manager/machines/personal.nix
      # "ansible-language-server" # via nix: home-manager/machines/personal.nix
    ];

    # whalebrews = [ "whalebrew/wget" ];

    casks = [
      "anki"
      "asana"
      # "bitwarden"
      "brave-browser"
      # "breitbandmessung"
      # "calibre"
      "claude"
      # "copilot-cli"
      # "cursor"
      # "docker"
      # "dotnet-sdk"
      "drawio"
      "darrylmorley/whatcable/whatcable"
      "electrum"
      "element"
      "firefox"
      # "flux"
      "focusrite-control"
      "garmin-express"
      # "ghostty" # via nix: home-manager/modules/gui-apps.nix
      # "google-chrome"
      # "hammerspoon"
      # "hiddenbar" # via nix: home-manager/modules/gui-apps.nix
      "insomnia"
      "itsycal"
      # "iterm2"
      "jetbrains-toolbox"
      "joplin"
      # "kitty"
      # "maccy" # via nix: home-manager/modules/gui-apps.nix
      "microsoft-auto-update"
      # "microsoft-teams" # not receiving updates from upstream currently
      "microsoft-outlook"
      "monitorcontrol"
      "nextcloud"
      # "obsidian"
      # "postman"
      # "portfolioperformance"
      "rectangle"
      "signal"
      # "slack"
      # "sonos"
      # "spotify"
      "stats"
      "teamviewer"
      # "telegram-desktop"
      "tigervnc"
      "tomighty"
      "utm"
      "visual-studio-code"
      "vlc"
      "whatsapp"
      "wireshark-app"
      "wispr-flow"
      "yubico-authenticator"
      # "zap"
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

    # masApps = {
    #   "AdGuard for Safari" = 1440147259;
    #   "AusweisApp Bund" = 948660805;
    #   # Bitwarden = 1352778147;
    #   iMovie = 408981434;
    #   "irealb Pro" = 409035833;
    #   Keynote = 409183694;
    #   Kindle = 302584613;
    #   "Logic Pro" = 634148309;
    #   Mactracker = 430255202;
    #   Numbers = 409203825;
    #   # Pages = 409201541;
    #   # "Slack for Desktop" = 803453959;
    #   "WireGuard" = 1451685025;
    #   # Xcode = 497799835;
    # };
  };
}
