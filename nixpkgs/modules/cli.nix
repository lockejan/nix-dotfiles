{ lib, config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    # dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    completionInit = "autoload -Uz compinit; compinit -u";
    defaultKeymap = "emacs";
    plugins = [{
      name = "fzf-tab";
      src = pkgs.fetchFromGitHub {
        owner = "Aloxaf";
        repo = "fzf-tab";
        rev = "e8145d541a35d8a03df49fbbeefa50c4a0076bbf";
        sha256 = "h/3XP/BiNnUgQI29gEBl6RFee77WDhFyvsnTi1eRbKg=";
        # sha256 = lib.fakeSha256;
      };
    }];

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
      www = "python -m SimpleHTTPServer 8000";
      pubip = "dig +short myip.opendns.com @resolver1.opendns.com";
      localip = ''
        ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'
      '';
      du = "du -cksh";
      df = "df -h";
      mkdir = "command mkdir -p";
      ssh = "TERM=xterm-256color ssh";
      sed = "sed -E";
      rollback = ''
        home-manager generations | fzf | awk '{activate=$NF"/activate"; print activate}' | bash - '';
    };
    initExtra = builtins.readFile ../configs/zsh/zshrc;
  };

  programs = {

    # command-not-found.enable = true;

    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };

    z-lua = {
      enable = true;
      enableAliases = true;
      enableZshIntegration = true;
      options = [ "enhanced" "once" "fzf" ];
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

    keychain = {
      enable = true;
      enableZshIntegration = true;
    };

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
        truncate_to_repo = false;
      };
    };
  };

}
