{ lib }:
# Helpers for macOS apps that store shortcuts as Carbon key codes and
# modifier masks (Hidden Bar, sindresorhus/KeyboardShortcuts, ...).
rec {
  # Virtual key codes (HIToolbox kVK_*)
  keyCodes = {
    A = 0; S = 1; D = 2; F = 3; H = 4; G = 5; Z = 6; X = 7; C = 8; V = 9;
    B = 11; Q = 12; W = 13; E = 14; R = 15; Y = 16; T = 17;
    "1" = 18; "2" = 19; "3" = 20; "4" = 21; "6" = 22; "5" = 23;
    "9" = 25; "7" = 26; "8" = 28; "0" = 29;
    O = 31; U = 32; I = 34; P = 35; L = 37; J = 38; K = 40; N = 45; M = 46;
    Return = 36; Tab = 48; Space = 49; Delete = 51; Escape = 53;
  };

  # Carbon modifier masks (cmdKey, shiftKey, optionKey, controlKey)
  modifierFlags = k:
    (if k.command then 256 else 0)
    + (if k.shift then 512 else 0)
    + (if k.option then 2048 else 0)
    + (if k.control then 4096 else 0);

  shortcutType = lib.types.submodule {
    options = {
      key = lib.mkOption {
        type = lib.types.enum (builtins.attrNames keyCodes);
        example = "V";
        description = "Key of the shortcut.";
      };
      command = lib.mkEnableOption "the Command modifier";
      shift = lib.mkEnableOption "the Shift modifier";
      option = lib.mkEnableOption "the Option modifier";
      control = lib.mkEnableOption "the Control modifier";
    };
  };
}
