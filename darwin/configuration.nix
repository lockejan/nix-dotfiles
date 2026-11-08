{ pkgs, pkgsUnstable, username, ... }:
let
  user = username;
in
{
  imports = [
    ./homebrew.nix
  ];
  users.users."${user}" = {
    name = "${user}";
    home = "/Users/${user}";
    shell = pkgsUnstable.zsh;
  };


  ids.gids.nixbld = 350;

  home-manager.backupFileExtension = "bak";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {

    systemPackages = [ pkgsUnstable.vim ];
    # environment.shells = [ pkgs.zsh ];

    variables = {
      SHELL = "${pkgsUnstable.zsh}/bin/zsh";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };

    etc."sudoers.d/000-sudo-touchid" = {
      text = ''
        Defaults pam_service=sudo-touchid
        Defaults pam_login_service=sudo-touchid
      '';
    };

    etc."pam.d/sudo-touchid" = {
      text = ''
        auth       optional       ${pkgsUnstable.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
        auth       sufficient     pam_tid.so
        auth       sufficient     pam_smartcard.so
        auth       required       pam_opendirectory.so
        account    required       pam_permit.so
        password   required       pam_deny.so
        session    required       pam_permit.so
      '';
    };
  };

  networking.hostName = "${user}-machine";

  # programs.gnupg.agent.enable = true;
  # programs.gnupg.agent.enableSSHSupport = true;

  system = {
    primaryUser = "${user}";
    defaults = {
      # persistent-apps/others stay here: nix-darwin generates the nested plist
      # dict format Dock.app requires; targets.darwin.defaults can't do this.
      dock = {
        persistent-apps = [
          "/System/Applications/System Settings.app"
          "/System/Applications/Utilities/Activity Monitor.app"
          "/Applications/Safari.app"
          "/Applications/Brave Browser.app"
          "/Users/${user}/Applications/Home Manager Apps/Ghostty.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/Joplin.app"
        ];
        persistent-others = [
          "/Users/${user}/Downloads"
          "/Users/${user}/Scratchpad"
          "/Users/${user}/Developer"
        ];
      };

      # System-level settings that require root — cannot live in home-manager.
      loginwindow.GuestEnabled = false;
      loginwindow.autoLoginUser = "${user}";
      # ActivityMonitor.SortDirection = 0;
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    };

    keyboard =
      {
        enableKeyMapping = true;
        nonUS.remapTilde = true;
        remapCapsLockToControl = true;
      };
  };

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

  nix = {

    package = pkgs.nix;

    settings = {
      sandbox = false;
      trusted-users = [ "@admin" ];
      # System-wide so root (sudo nix ..., launchd jobs) gets them too.
      experimental-features = [ "nix-command" "flakes" ];
      extra-sandbox-paths = [
        "/private/tmp"
        "/private/var/tmp"
        "/usr/bin/env"
      ];

      substituters = [
        "https://nix-community.cachix.org"
        "https://lockejan-nur.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "lockejan-nur.cachix.org-1:xRzsQG4xTHMx7piti7DD6iwu+bR7pdeAJEd5VwdZCv4="
      ];

      log-lines = 128;

      # Let the collector drop build-time dependencies (compilers, sources)
      # once nothing live needs them. Keeping them pinned the whole build
      # closure of every generation and let the store grow past 300 GB.
      keep-outputs = false;
      keep-derivations = false;
    };

    # Monday-morning GC of generations older than two weeks, scheduled for
    # when the laptop is awake. Runs as root via launchd, so it also prunes
    # the system profile that a user-level `nix-collect-garbage` cannot reach.
    gc = {
      automatic = true;
      interval = { Weekday = 1; Hour = 10; Minute = 30; };
      options = "--delete-older-than 14d";
    };

    # Hard-link deduplication of the store, an hour after GC. Replaces
    # `auto-optimise-store`, which is unreliable on macOS.
    optimise = {
      automatic = true;
      interval = { Weekday = 1; Hour = 11; Minute = 30; };
    };

  };

  # programs.nix-index.enable = true;

  # Fonts
  fonts.packages = with pkgsUnstable; [
    recursive
    nerd-fonts.jetbrains-mono
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
