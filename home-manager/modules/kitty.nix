{ config, pkgs, libs, ... }: {
  programs.kitty = {
    enable = false;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
    };
    extraConfig = ''
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
      disable_ligatures never
      macos_option_as_alt yes
      include One Dark.conf
    '';
  };
  xdg.configFile."kitty/kitty.conf".source =
    config.lib.file.mkOutOfStoreSymlink ../configs/kitty/kitty.conf;
  xdg.configFile."kitty/OneDark.conf".source =
    config.lib.file.mkOutOfStoreSymlink ../configs/kitty/OneDark.conf;
}
