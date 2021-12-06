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
  /*     window.dimensions = { */
  /*       lines = 3; */
  /*       columns = 200; */
  /*     }; */
  /*   }; */
  /* }; */
}
