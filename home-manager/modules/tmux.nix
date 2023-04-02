{ nixpkgs-unstable, ... }:
{ config, pkgs, libs, ... }:
let
  unstable = nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{

  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    baseIndex = 1;
    disableConfirmationPrompt = false;
    escapeTime = 40;
    historyLimit = 10000;
    keyMode = "emacs";
    # aggressiveResize = true;
    newSession = false;
    plugins = with unstable; [
      tmuxPlugins.tmux-fzf
      tmuxPlugins.fzf-tmux-url
      tmuxPlugins.prefix-highlight
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-dir '~/.local/share/tmux/resurrect'
          set -g @resurrect-capture-pane-contents 'off'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10' # minutes
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
