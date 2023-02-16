{ lib, config, pkgs, ... }:
let
  dir = "${config.home.homeDirectory}/dotfiles/home-manager/machines";
in
{

  programs.zsh = {
    enable = true;
    autocd = true;
    # dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    # completionInit = "autoload -Uz compinit; compinit -u";
    defaultKeymap = "emacs";
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "14f66e4d3d0b366552c0412eb08ca9e0f7c797bd";
          sha256 = "sha256-YkfHPSuSKParz7JidR924CJSuXO6Rk0RZTlxPOBwLJk=";
          # sha256 = lib.fakeSha256;
        };
      }
      {
        name = "zsh-z";
        src = pkgs.fetchFromGitHub {
          owner = "agkozak";
          repo = "zsh-z";
          rev = "82f5088641862d0e83561bb251fb60808791c76a";
          sha256 = "sha256-6BNYzfTcjWm+0lJC83IdLxHwwG4/DKet2QNDvVBR6Eo=";
          # sha256 = lib.fakeSha256;
        };
      }
    ];

    history = {
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 10000;
      share = true;
      size = 10000;
    };

    shellAliases = {
      zc = "$EDITOR ~/.zshrc";
      clj-tip = "bb ~/random_doc.clj";
      vc = "$EDITOR ~/.config/nvim/init.lua";
      n = "nvim";
      s = "kitty +kitten ssh";
      ssh = "TERM=xterm-256color ssh";
      diff = "diff --color=auto";
      grep = "grep --color=auto";
      www = "python -m SimpleHTTPServer 8000";
      pubip = "dig +short myip.opendns.com @resolver1.opendns.com";
      localip = ''
        ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'
      '';
      du = "du -cksh";
      df = "df -h";
      mkdir = "command mkdir -p";
      sed = "sed -E";
      rollback = ''
        home-manager generations | fzf | awk '{activate=$NF"/activate"; print activate}' | bash - '';
    };
    initExtra = builtins.readFile ../configs/zsh/zshrc;
  };

  programs = {

    command-not-found.enable = false;
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    bat = {
      enable = true;
      config = {
        theme = "OneHalfDark";
        italic-text = "always";
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f";
      defaultOptions = [ "--height 60%" "--border" ];
      # fileWidgetCommand = "fd --type f";
      # fileWidgetOptions = [ "--preview 'head {}'" ];
      # historyWidgetOptions = [ "--sort" "--exact" ];
      changeDirWidgetCommand = "fd --type d";
      tmux = {
        enableShellIntegration = true;
        shellIntegrationOptions = [ "-d 60%" ];
      };
    };

    # keychain = {
    #   enable = true;
    #   enableZshIntegration = true;
    # };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {

        add_newline = true;
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$directory"
          "$git_branch"
          "$git_state"
          "$git_status"
          "$nix_shell"
          "$cmd_duration"
          "$line_break"
          "$jobs"
          "$python"
          "$character"
        ];

        scan_timeout = 10;

        # directory = {
        #   style = "blue";
        # };

        character = {
          success_symbol = "[λ](purple)";
          error_symbol = "[λ](red)";
          vicmd_symbol = "[](green)";
        };

        git_branch = {
          format = "[$branch]($style)";
          style = "bright-black";
        };

        git_status = {
          format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style) ";
          style = "cyan";
          conflicted = "​";
          untracked = "​";
          modified = "​";
          staged = "​";
          renamed = "​";
          deleted = "​";
          stashed = "≡";
        };

        git_state = {
          format = "\([ $state ($progress_current/$progress_total) ] ($style)\) ";
          style = "bright-black";
          cherry_pick = "[🍒 PICKING](bold red)";
          disabled = true;
        };

        git_commit = {
          commit_hash_length = 4;
          tag_symbol = "🔖 ";
        };

        cmd_duration = {
          format = "[$duration]($style) ";
          style = "yellow";
        };

        python = {
          format = "[$virtualenv]($style) ";
          style = "bright-black";
        };

        nix_shell = {
          format = "[$symbol$state]($style) ";
          symbol = " ";
        };
      };
    };
  };

  home.file."random_doc.clj".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/random_doc.clj";
}
