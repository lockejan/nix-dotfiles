{ config, lib, pkgs, ... }:
let
  cfg = config.programs.hidden-bar;
  domain = "com.dwarvesv.minimalbar";
  keys = import ../helpers/carbon-keys.nix { inherit lib; };

  globalKeyJSON = k: builtins.toJSON {
    characters = k.key;
    keyCode = keys.keyCodes.${k.key};
    carbonFlags = keys.modifierFlags k;
    inherit (k) command shift option control;
    capsLock = false;
    function = false;
  };
in
{
  options.programs.hidden-bar = {
    enable = lib.mkEnableOption "Hidden Bar, a macOS menu bar organizer";

    package = lib.mkPackageOption pkgs "hidden-bar" { nullable = true; };

    launchd = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Configure the launchd agent to start Hidden Bar at login. It is
          restarted only after a crash; quitting the app keeps it closed.

          Verify with `launchctl list | grep hidden-bar`; logs go to
          {file}`/tmp/hidden-bar.err.log`.

          NOTE: Enabling this sets the app's own "Start at login" preference
          to false, as starting is handled by launchd instead. A login item
          already registered through the app's toggle is not removed by this;
          turn the toggle off in the app or remove it in System Settings.
        '';
      };
    };

    settings = lib.mkOption {
      type = with lib.types; attrsOf (oneOf [ bool int str ]);
      default = { };
      example = {
        areSeparatorsHidden = true;
        alwaysHiddenSectionEnabled = false;
      };
      description = ''
        Preferences written to the `${domain}` defaults domain. Keys not set
        here stay under the app's control. Read the current values with
        `defaults read ${domain}`.
      '';
    };

    globalKey = lib.mkOption {
      type = lib.types.nullOr keys.shortcutType;
      default = null;
      example = { key = "H"; command = true; shift = true; };
      description = "Global shortcut that toggles the hidden icons.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "programs.hidden-bar" pkgs lib.platforms.darwin)
      {
        assertion = cfg.launchd.enable -> (cfg.settings.isAutoStart or false) == false;
        message = "programs.hidden-bar.settings.isAutoStart conflicts with programs.hidden-bar.launchd.enable";
      }
      {
        assertion = cfg.launchd.enable -> cfg.package != null;
        message = "programs.hidden-bar.launchd.enable requires programs.hidden-bar.package to be set";
      }
    ];

    home.packages = lib.optional (cfg.package != null) cfg.package;

    # Hidden Bar is sandboxed; cfprefsd redirects these writes into
    # ~/Library/Containers/com.dwarvesv.minimalbar. `defaults import` merges,
    # so unmanaged keys (e.g. menu bar positions) are left alone.
    targets.darwin.defaults.${domain} =
      cfg.settings
      # launchd starts the app instead; same approach as programs.aerospace
      // lib.optionalAttrs cfg.launchd.enable { isAutoStart = false; };

    # Same agent shape as services.flameshot (menu bar app)
    launchd.agents.hidden-bar = {
      inherit (cfg.launchd) enable;
      config = {
        Program = "${cfg.package}/Applications/Hidden Bar.app/Contents/MacOS/Hidden Bar";
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        ProcessType = "Interactive";
        RunAtLoad = true;
        StandardOutPath = "/tmp/hidden-bar.log";
        StandardErrorPath = "/tmp/hidden-bar.err.log";
      };
    };

    # globalKey is a JSON blob stored as plist data, which toPlist can't emit.
    home.activation.hiddenBarGlobalKey = lib.mkIf (cfg.globalKey != null) (
      lib.hm.dag.entryAfter [ "setDarwinDefaults" ] ''
        run /usr/bin/defaults write ${domain} globalKey -data \
          "$(printf '%s' ${lib.escapeShellArg (globalKeyJSON cfg.globalKey)} | /usr/bin/xxd -p | tr -d '\n')"
      ''
    );
  };
}
