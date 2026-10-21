{ lib, pkgs, pkgsUnstable, ... }: {
  imports = [
    ./hidden-bar.nix
    ./maccy.nix
  ];

  # GUI apps installed via nix instead of homebrew casks.
  # home-manager's targets.darwin.copyApps (default since stateVersion 25.11)
  # copies the .app bundles to ~/Applications/Home Manager Apps, where
  # Spotlight and Launchpad index them.
  # Only use packages that ship the upstream-signed .app (check with
  # `codesign -dv`). Ad-hoc signed source builds get a new identity on every
  # update, which resets Accessibility grants, and some change the bundle ID.
  # Mirrors the settings made in the app on 2026-10-19
  programs.hidden-bar = {
    enable = true;
    launchd.enable = true;
    settings = {
      areSeparatorsHidden = true;
      alwaysHiddenSectionEnabled = false;
      useFullStatusBarOnExpandEnabled = false;
      isShowPreferences = false;
    };
    globalKey = { key = "H"; command = true; shift = true; };
  };

  # Mirrors the settings made in the app on 2026-10-20
  programs.maccy = {
    enable = true;
    package = pkgsUnstable.maccy;
    launchd.enable = true;
    settings = {
      pasteByDefault = true;
      removeFormattingByDefault = true;
      searchMode = "fuzzy";
      maxMenuItems = 100;
    };
    shortcuts = {
      popup = { key = "V"; command = true; shift = true; };
      pin = { key = "P"; option = true; };
      delete = { key = "Delete"; option = true; };
      togglePreview = { key = "Space"; control = true; };
    };
  };

  programs.ghostty = {
    enable = true;
    # ncurses already ships a ghostty terminfo entry; let it win the conflict
    package = lib.lowPrio pkgs.ghostty-bin;
    installBatSyntax = true;
    settings = {
      quit-after-last-window-closed = true;
      theme = "Kanagawa Wave";
      bold-is-bright = true;
      font-size = 14;
      font-thicken = false;
      font-family = "JetBrainsMono Nerd Font Mono";
      macos-option-as-alt = true;
      # updates come from nix
      auto-update = "off";
    };
  };
}
