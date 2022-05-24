{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [ extract_url ];

  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    baseIndex = 1;
    disableConfirmationPrompt = false;
    escapeTime = 40;
    historyLimit = 5000;
    # keyMode = "vi";
    newSession = true;
    plugins = with pkgs; [
      tmuxPlugins.urlview
      tmuxPlugins.onedark-theme
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
          set -g @continuum-boot-options 'iterm'
        '';
      }
    ];
    prefix = "C-a";
    resizeAmount = 10;
    secureSocket = true;
    sensibleOnTop = false;
    terminal = "xterm-256color";
    extraConfig = builtins.readFile ../configs/tmux/tmux.conf;
  };
  xdg.configFile."tmux/tmux.mac.conf".source = ../configs/tmux/tmux.mac.conf;
}
