{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    extract_url
  ];

  programs.tmux =
    {
      enable = true;
      package = pkgs.tmux;
      baseIndex = 1;
      disableConfirmationPrompt = false;
      escapeTime = 500;
      historyLimit = 5000;
      /* keyMode = "vi"; */
      newSession = false;
      /* plugins = with pkgs; [ */
      /*   tmuxPlugins.cpu */
      /*   tmuxPlugins.urlview */
      /*   { */
      /*     plugin = tmuxPlugins.resurrect; */
      /*     extraConfig = "set -g @resurrect-strategy-nvim 'session'"; */
      /*   } */
      /* ]; */
      prefix = "C-a";
      resizeAmount = 10;
      secureSocket = true;
      sensibleOnTop = false;
      terminal = "tmux-256color";
      extraConfig = builtins.readFile ../configs/tmux/tmux.conf;
    };
  xdg.configFile."tmux/tmux.mac.conf".source = ../configs/tmux/tmux.mac.conf;
}
