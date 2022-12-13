{ config, pkgs, libs, ... }:
let
  unstable = pkgs;
  # unstable = import <unstable> {
  #   config.allowUnfree = true;
  # };
in
{

  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    baseIndex = 1;
    disableConfirmationPrompt = false;
    escapeTime = 40;
    historyLimit = 5000;
    keyMode = "emacs";
    # aggressiveResize = true;
    newSession = false;
    plugins = with unstable; [
      tmuxPlugins.tmux-fzf
      tmuxPlugins.fzf-tmux-url
      # tmuxPlugins.fingers
      tmuxPlugins.prefix-highlight
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-dir '~/.local/share/tmux/resurrect'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10' # minutes
          set -g @continuum-boot 'on'
          set -g @continuum-boot-options 'alacritty'
        '';
      }
    ];
    prefix = "C-a";
    resizeAmount = 10;
    secureSocket = true;
    sensibleOnTop = false;
    terminal = "xterm-kitty";
    extraConfig = builtins.readFile ../configs/tmux/tmux.conf;
  };

  xdg.configFile."tmux/tmux.mac.conf".source = ../configs/tmux/tmux.mac.conf;
}
