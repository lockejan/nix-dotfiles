{ config, pkgs, libs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
    };
    extraConfig =
      ''
        bold_font        auto
        italic_font      auto
        bold_italic_font auto
        disable_ligatures never

        include One Dark.conf
      '';
  };
}