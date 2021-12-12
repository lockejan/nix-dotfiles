{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    alacritty
    # libsixel
  ];
  xdg.configFile."alacritty/alacritty.yml".source = ../configs/alacritty/alacritty.yml;
  xdg.configFile."alacritty/one-dark.yml".source = ../configs/alacritty/one-dark.yml;
  xdg.configFile."alacritty/osx-keybindings.yml".source = ../configs/alacritty/osx-keybindings.yml;

  /* programs.alacritty = { */
  /*   enable = true; */
  /*   settings = { */
  /*     env.TERM = "xterm-256color-italic"; */
  /*     /1* alt_send_esc = false; *1/ */
  /*     background_opacity = 1; */

  /*     window = { */
  /*       dynamic_title = true; */
  /*       dynamic_padding = false; */
  /*       decorations = "full"; */
  /*       dimensions = { lines = 0; columns = 0; }; */
  /*       padding = { x = 5; y = 5; }; */
  /*       class = { */
  /*         instance = "Alacritty"; */
  /*         general = "Alacritty"; */
  /*       }; */
  /*     }; */

  /*     shell = { */
  /*       program = "${builtins.getEnv "HOME"}/.nix-profile/bin/zsh"; */
  /*     }; */

  /*     scrolling = { */
  /*       history = 50000; */
  /*       multiplier = 3; */
  /*     }; */

  /*     mouse = { hide_when_typing = true; }; */

  /*     font = let fontname = "JetBrainsMono Nerd Font"; in */
  /*       { */
  /*         normal = { family = fontname; style = "Regular"; }; */
  /*         bold = { family = fontname; style = "Bold"; }; */
  /*         italic = { family = fontname; style = "Italic"; }; */
  /*         bold_italic = { family = fontname; style = "Bold Italic"; }; */
  /*         size = 14; */
  /*       }; */
  /*     cursor.style = "Block"; */

  /*     key_bindings = [ */
  /*       { */
  /*         # clear terminal */
  /*         key = "L"; */
  /*         mods = "Control"; */
  /*         chars = "\\x0c"; */
  /*       } */
  /*     ]; */

  /*     colors = { */
  /*       primary = { */
  /*         background = "0x24283b"; */
  /*         foreground = "0xc0caf5"; */
  /*       }; */
  /*       #cursor = { */
  /*       #text = ""; */
  /*       #cursor = ""; */
  /*       #}; */
  /*       normal = { */
  /*         black = "0x1D202F"; */
  /*         red = "0xf7768e"; */
  /*         green = "0x9ece6a"; */
  /*         yellow = "0xe0af68"; */
  /*         blue = "0x7aa2f7"; */
  /*         magenta = "0xbb9af7"; */
  /*         cyan = "0x7dcfff"; */
  /*         white = "0xa9b1d6"; */
  /*       }; */
  /*       bright = { */
  /*         black = "0x414868"; */
  /*         red = "0xf7768e"; */
  /*         green = "0x9ece6a"; */
  /*         yellow = "0xe0af68"; */
  /*         blue = "0x7aa2f7"; */
  /*         magenta = "0xbb9af7"; */
  /*         cyan = "0x7dcfff"; */
  /*         white = "0xc0caf5"; */
  /*       }; */
  /*       indexed_colors = [ */
  /*         { index = 16; color = "0xff9e64"; } */
  /*         { index = 17; color = "0xdb4b4b"; } */
  /*       ]; */
  /*     }; */
  /*   }; */
  /* }; */
}
