{ config, lib, pkgs, ... }:
let
  cfg = config.programs.maccy;
  domain = "org.p0deje.Maccy";
  keys = import ../helpers/carbon-keys.nix { inherit lib; };

  # sindresorhus/KeyboardShortcuts stores each shortcut as a JSON string
  shortcutJSON = k: builtins.toJSON {
    carbonKeyCode = keys.keyCodes.${k.key};
    carbonModifiers = keys.modifierFlags k;
  };
in
{
  options.programs.maccy = {
    enable = lib.mkEnableOption "Maccy, a clipboard manager for macOS";

    package = lib.mkPackageOption pkgs "maccy" { nullable = true; };

    launchd = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Configure the launchd agent to start Maccy at login. It is restarted
          only after a crash; quitting the app keeps it closed.

          Verify with `launchctl list | grep maccy`; logs go to
          {file}`/tmp/maccy.err.log`.

          NOTE: Maccy's own "Launch at login" setting is not stored in its
          preferences, so turn it off in the app to avoid starting it twice.
        '';
      };
    };

    settings = lib.mkOption {
      type = with lib.types; attrsOf (oneOf [ bool int str (listOf str) ]);
      default = { };
      example = {
        pasteByDefault = true;
        searchMode = "fuzzy";
      };
      description = ''
        Preferences written to the `${domain}` defaults domain. Keys not set
        here stay under the app's control. Read the current values with
        `defaults read ${domain}`.
      '';
    };

    shortcuts = lib.mkOption {
      type = lib.types.attrsOf keys.shortcutType;
      default = { };
      example = {
        popup = { key = "V"; command = true; shift = true; };
      };
      description = ''
        Keyboard shortcuts, keyed by name (`popup`, `pin`, `delete`,
        `togglePreview`). Written as `KeyboardShortcuts_<name>`.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "programs.maccy" pkgs lib.platforms.darwin)
      {
        assertion = cfg.launchd.enable -> cfg.package != null;
        message = "programs.maccy.launchd.enable requires programs.maccy.package to be set";
      }
    ];

    home.packages = lib.optional (cfg.package != null) cfg.package;

    # Maccy is sandboxed; cfprefsd redirects these writes into its container.
    # `defaults import` merges, so unmanaged keys are left alone.
    targets.darwin.defaults.${domain} =
      lib.optionalAttrs (cfg.package != null) {
        # Sparkle would replace the nix-managed app; updates come from nix
        SUEnableAutomaticChecks = false;
        SUAutomaticallyUpdate = false;
      }
      // cfg.settings
      // lib.mapAttrs' (name: k: lib.nameValuePair "KeyboardShortcuts_${name}" (shortcutJSON k)) cfg.shortcuts;

    # Same agent shape as services.flameshot (menu bar app)
    launchd.agents.maccy = {
      inherit (cfg.launchd) enable;
      config = {
        Program = "${cfg.package}/Applications/Maccy.app/Contents/MacOS/Maccy";
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        ProcessType = "Interactive";
        RunAtLoad = true;
        StandardOutPath = "/tmp/maccy.log";
        StandardErrorPath = "/tmp/maccy.err.log";
      };
    };
  };
}
