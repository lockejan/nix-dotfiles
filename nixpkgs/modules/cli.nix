{ lib, config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
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
        rev = "a677cf770cfce1e3668ba576fecfb7a14f4f39e2";
        sha256 = "Qf9AZ2DjO9QUyEF7QG8JtlBHjwHfINOJkrMfu7pipns=";
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
      update =
        "nix-channel --update && home-manager switch && lsp-update && nvim --headless +'autocmd User PackerComplete quitall' +PackerSync";
      zc = "$EDITOR ~/.zshrc";
      vc = "$EDITOR ~/.config/nvim/init.lua";
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
      luamake = (builtins.getEnv "HOME"
        + "/.cache/nvim/nlua/sumneko_lua/3rd/luamake/luamake");
    };
    initExtra = builtins.readFile ../configs/zsh/zshrc;
  };

  programs = {
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
  };
}
