{ lib, config, pkgs, inputs, ... }:
let
  dir = "${config.home.homeDirectory}/dotfiles/home-manager/machines";
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  # home.packages = with unstable;[
  #   zsh-fzf-tab
  # ];

  programs.zsh = {
    enable = true;
    autocd = true;
    # dotDir = ".config/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    # https://github.com/nix-community/home-manager/issues/2562#issuecomment-1009381061
    initExtraBeforeCompInit = ''
      fpath+=("${config.home.profileDirectory}"/share/zsh/site-functions
      "${config.home.profileDirectory}"/share/zsh/$ZSH_VERSION/functions
      "${config.home.profileDirectory}"/share/zsh/vendor-completions
      /usr/local/share/zsh/site-functions/)
    '';
    completionInit = "autoload -Uz compinit; compinit -u";
    defaultKeymap = "emacs";
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "14e16f0d36ae9938e28b2f6efdb7344cd527a1a6";
          sha256 = "sha256-o8hgnTl84nI7jMVfA5jEcDXkMFFlnxKbRva+l/Fx4jI=";
          # sha256 = lib.fakeSha256;
        };
      }
      {
        name = "zsh-z";
        src = pkgs.fetchFromGitHub {
          owner = "agkozak";
          repo = "zsh-z";
          rev = "afaf2965b41fdc6ca66066e09382726aa0b6aa04";
          sha256 = "sha256-FnGjp/VJLPR6FaODY0GtCwcsTYA4d6D8a6dMmNpXQ+g=";
          # sha256 = lib.fakeSha256;
        };
      }
    ];

    history = {
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 20000;
      share = true;
      size = 20000;
    };

    shellAliases = {
      zc = "$EDITOR ~/.zshrc";
      clj-tip = "bb ~/random_doc.clj";
      vc = "$EDITOR ~/.config/nvim/init.lua";
      n = "nvim";
      s = "kitty +kitten ssh";
      ssh = "TERM=xterm-256color ssh";
      # diff = "diff --color=auto";
      grep = "grep --color=auto";
      www = "python3 -m http.server 8000";
      pubip = "dig +short myip.opendns.com @resolver1.opendns.com";
      localip = ''
        ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'
      '';
      du = "du -cksh";
      df = "df -h";
      tn = "open 'xyz.kondor.znotch://v1/manage?action=hide'";
      mkdir = "command mkdir -p";
      sed = "sed -E";
      uuid = "uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n' | pbcopy";
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

    eza = {
      enable = true;
      enableZshIntegration = true;
    };

    bat = {
      enable = true;
      config = {
        # theme = "OneHalfDark";
        italic-text = "always";
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f";
      defaultOptions = [
        "--height 60%"
        "--border"
        # "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
      ];
      # fileWidgetCommand = "fd --type f";
      fileWidgetOptions = [ "--preview 'bat --color=always --style=numbers --line-range=:500 {}'" ];
      # historyWidgetOptions = [ "--sort" "--exact" ];
      changeDirWidgetCommand = "fd --type d";
      tmux = {
        enableShellIntegration = true;
        shellIntegrationOptions = [
          "-d 60%"
        ];
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

    k9s = {
      enable = true;
    };
  };

  home.file."random_doc.clj".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/random_doc.clj";
}
