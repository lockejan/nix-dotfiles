{ lib, config, pkgs, ... }: {
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
          rev = "7e0eee64df6c7c81a57792674646b5feaf89f263";
          sha256 = "sha256-ixUnuNtxxmiigeVjzuV5uG6rIBPY/1vdBZF2/Qv0Trs=";
          # sha256 = lib.fakeSha256;
        };
      }
      {
        name = "zsh-z";
        src = pkgs.fetchFromGitHub {
          owner = "agkozak";
          repo = "zsh-z";
          rev = "b5e61d03a42a84e9690de12915a006b6745c2a5f";
          sha256 = "1A6WZ+fJSf2WKZD7CYJB/pbgwV2mX+X8qInqQLeuT78=";
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
      vc = "$EDITOR ~/.config/nvim/init.lua";
      n = "nvim";
      s = "kitty +kitten ssh";
      diff="diff --color=auto";
      grep="grep --color=auto";
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
      settings.directory = {
        truncation_length = 8;
        truncation_symbol = "../";
        truncate_to_repo = false;
      };
      settings.git_commit = {
        # only_detached = false;
        # tag_disabled = false;
      };
    };
  };

}
