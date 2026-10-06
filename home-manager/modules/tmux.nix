{ config, lib, pkgs, pkgsUnstable, ... }:

{
  programs.tmux = {
    enable = true;
    package = pkgsUnstable.tmux;
    baseIndex = 1;
    disableConfirmationPrompt = false;
    escapeTime = 40;
    historyLimit = 50000;
    keyMode = "emacs";
    # aggressiveResize = true;
    newSession = false;
    plugins = with pkgsUnstable; [
      tmuxPlugins.tmux-fzf
      tmuxPlugins.fzf-tmux-url
      tmuxPlugins.prefix-highlight
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-dir '~/.local/share/tmux/resurrect'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      # continuum is loaded at the end of extraConfig instead, see below.
    ];
    # prefix = "C-a";
    resizeAmount = 10;
    # Puts TMUX_TMPDIR under /run/user/<uid>, which only exists on Linux
    # (systemd-logind). On macOS tmux would silently fall back to /tmp.
    secureSocket = pkgs.stdenv.isLinux;
    sensibleOnTop = false;
    terminal = "tmux-256color";
    # Home Manager runs plugins before extraConfig. continuum hooks itself into
    # status-right when it loads, and our status line config then overwrites
    # that option, so autosave silently never fires. Load continuum last.
    extraConfig = builtins.readFile ../configs/tmux/tmux.conf + ''

      # tmuxplugin-continuum (must come after status-right is set)
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '10' # minutes
      run-shell ${pkgsUnstable.tmuxPlugins.continuum.rtp}
    '';
  };

  xdg.configFile."tmux/tmux.mac.conf".source = ../configs/tmux/tmux.mac.conf;

  # macOS reaps entries in /tmp that have not been accessed for ~3 days, and a
  # unix socket's atime is not touched by connect(). A long-running tmux server
  # then loses its socket ("error connecting to /private/tmp/tmux-<uid>/default").
  # Keep the socket in a persistent, user-owned directory instead.
  home.sessionVariables = lib.mkIf pkgs.stdenv.isDarwin {
    TMUX_TMPDIR = "${config.xdg.stateHome}/tmux";
  };
  xdg.stateFile."tmux/.keep" = lib.mkIf pkgs.stdenv.isDarwin { text = ""; };
}
