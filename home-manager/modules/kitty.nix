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
      cursor_shape     beam
      italic_font      auto
      bold_italic_font auto
      disable_ligatures never
      macos_option_as_alt yes
      tab_bar_style powerline
      macos_titlebar_color background
      include everforestDarkMedium.conf
    '';
  };
  xdg.configFile."kitty/kitty.conf".source =
    config.lib.file.mkOutOfStoreSymlink ../configs/kitty/kitty.conf;
  xdg.configFile."kitty/kanagawa.conf".source =
    config.lib.file.mkOutOfStoreSymlink ../configs/kitty/kanagawa.conf;
  xdg.configFile."kitty/OneDark.conf".source =
    config.lib.file.mkOutOfStoreSymlink ../configs/kitty/OneDark.conf;
  xdg.configFile."kitty/everforestDarkMedium.conf".source =
    config.lib.file.mkOutOfStoreSymlink ../configs/kitty/everforestDarkMedium.conf;
}
