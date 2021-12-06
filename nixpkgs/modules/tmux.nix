{ config, pkgs, libs, ... }:
{
  programs.tmux =
    {
      enable = true;
      /* package = pkgs.tmux; */
      baseIndex = 1;
      disableConfirmationPrompt = false;
      escapeTime = 500;
      extraConfig = ''
        set -g mode-keys emacs
        set -g status-keys emacs

        # Setting the prefix from C-b to C-a
        set-option -g prefix C-a
        # bind-key C-a last-window
        unbind-key C-b

        # Ensure that we can send C-a to other apps
        bind-key a send-prefix

        # Setting the delay between prefix and command
        set -s escape-time 0

        # key repeat listen time
        # set-option -g repeat-time 5

        # scrollback buffer size
        set -g history-limit 50000

        # Reduce time to wait for escape key. handy for neovim
        set-option escape-time 40

        # renumber windows when a window is closed
        set -g renumber-windows off

        # Set the base for windos to 1 instead of 0
        set -g base-index 1

        # Set the base index for panes to 1 instead of 0
        setw -g pane-base-index 1

        # shortcut for synchronize-panes toggle
        bind C-p set-window-option synchronize-panes

        # source tmux
        bind r source-file ~/.tmux.conf \; source-file ~/.config/tmux/tmux.conf \; display "config reloaded!"

        # shortcut to kill pane
        #bind x killp

        # split panes with | and -
        bind "\\" split-window -h
        bind "'" split-window -v

        # split pane and retain the current dir of existing pane
        bind "|" split-window -h -c "#{pane_current_path}"
        bind "\"" split-window -v -c "#{pane_current_path}"

        # pane movement
        bind C-i command-prompt -p "join pane from:"  "join-pane -s '%%'"
        bind C-m command-prompt -p "send pane to:"  "join-pane -t '%%'"
        # window movement
        bind-key M command-prompt -p "swap window with:"  "swap-window -t '%%'"

        # quick win select
        # bind -r C-h select-window -t :-
        # bind -r C-l select-window -t :+

        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5

        set -g mouse on
        bind-key m set-option -g mouse \; display "Mouse: #{?mouse,ON,OFF}"

        # neovim add-ons
        set -g default-terminal "tmux-256color"
        set -as terminal-overrides ',xterm*:Tc:sitm=\E[3m'

        setw -g xterm-keys on

        set-option -g focus-events on

        # enabke vi keys
        setw -g mode-keys vi

        # esc turns on copy mode
        bind Escape copy-mode

        # vim like select and copy
        bind-key -T copy-mode v send -X begin-selection
        bind-key -T copy-mode y send -X copy-selection

        # make Prefix p paste the buffer.
        unbind p
        bind p paste-buffer

        # remap previous window
        bind b previous-window

        # create session
        # bind C-n new-session

        # bind-key X confirm-before -p "Kill #S (y/n)?" "run-shell 'tmux switch-client -n \\\; kill-session -t \"#S\"'"
        bind X command-prompt -p "kill:"  "switch-client -n \; kill-session -t '%%'"

        # show tmux buffers
        bind C-b choose-buffer
        # bind B list-buffers
        # bind b choose-buffer
        bind C-a send-keys 'C-a'
        # bind C-e send-keys 'C-e'
        bind C-l send-keys 'C-l'
        bind C-k send-keys 'C-k'

        bind i run-shell "tmux neww -n cheat.sh ~/bin/tmux-cht.sh"

        # Log output to a text file on demand
        # bind P pipe-pane -o "cat >>~/#W.log" \; display "Toggled logging to $HOME/#W.log"

        # Load osx specific setting
        if-shell "uname | grep -q Darwin" "source-file ~/.tmux.mac.conf"

        # load private settings if they exist
        if-shell "[ -f ~/.tmux.private ]" "source ~/.tmux.private"

        set -g status-right '#{prefix_highlight}'

        set -g @tpm_plugins ' \
            tmux-plugins/tpm \
            christoomey/vim-tmux-navigator \
            tmux-plugins/tmux-urlview \
            tmux-plugins/tmux-resurrect \
            tmux-plugins/tmux-continuum \
            odedlaz/tmux-onedark-theme \
            tmux-plugins/tmux-prefix-highlight \
            '

        set -g @resurrect-strategy-nvim 'session'
        set -g @continuum-boot 'alacritty'
        set -g @continuum-boot 'on'

        run '~/.tmux/plugins/tpm/tpm'
      '';
      historyLimit = 5000;
      keyMode = "vi";
      newSession = true;
      plugins = with pkgs; [
        tmuxPlugins.cpu
        tmuxPlugins.urlview
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
      ];
      prefix = "C-a";
      resizeAmount = 10;
      secureSocket = true;
      sensibleOnTop = false;
      terminal = "tmux-256color";
    };
  /* xdg.configFile."tmux/tmux.conf".source = ../configs/tmux/tmux.conf; */
}
