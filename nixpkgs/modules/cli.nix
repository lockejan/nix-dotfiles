{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    /* zsh-fzf-tab */
    /* zsh-z */
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = false;
    /* environment.pathsToLink = ["/share/zsh"]; */
    enableSyntaxHighlighting = true;
    defaultKeymap = "emacs";
    history =
      {
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
        save = 10000;
        share = true;
        size = 10000;
      };
    /* oh-my-zsh = { */
    /*   enable = true; */
    /*   plugins = [ "git" ]; */
    /*   theme = "robbyrussell"; */
    /* }; */
    plugins = [
      /* { */
      /*   name = "zsh-z"; */
      /*   src = pkgs.fetchFromGitHub { */
      /*     owner = "agkozak"; */
      /*     repo = "zsh-z"; */
      /*     rev = "b30bc6050e77abe30ce36761d18ed696e5410f16"; */
      /*     sha256 = "TSX6KooWYGf1NDlD4A3o6CmSsyy1JL7bPeKsuCOuUhY="; */
      /*     /1* sha256 = lib.fakeSha256; *1/ */
      /*   }; */
      /* } */
      {
        name = "zsh-fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "a677cf770cfce1e3668ba576fecfb7a14f4f39e2";
          sha256 = "Qf9AZ2DjO9QUyEF7QG8JtlBHjwHfINOJkrMfu7pipns=";
        };
      }
    ];

    /* completionInit = "autoload -U compinit && compinit"; */
    shellAliases = {
      update = ''
        nix-channel --update && home-manager switch && lsp-update
      '';
      zc = "$EDITOR ~/.zshrc";
      vc = "$EDITOR ~/.config/nvim/init.lua";
      www = "python -m SimpleHTTPServer 8000";
      /* ls = "exa"; #-FGh"; */
      /* ll = "exa -l"; #FGh"; */
      /* la = "exa -la"; #FGh"; */
      pubip = "dig +short myip.opendns.com @resolver1.opendns.com";
      localip = ''
        ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'
      '';
      du = "du -cksh";
      df = "df -h";
      mkdir = "command mkdir -p";
      ssh = "TERM=xterm-256color ssh";
      /* \$ =''; */
      # use modern regex patterns for sed, i.e. "(one|two)", not "\(one\|two\)"
      sed = "sed -E";
      lsp-update = ''
          cd ~/.cache/nvim/nlua/sumneko_lua &&
        git pull &&
        cd 3rd/luamake &&
        compile/install.sh &&
        cd ../.. &&
        ./3rd/luamake/luamake rebuild && cd '';

    };
    initExtra = builtins.readFile ../configs/zsh/zshrc;
  };
  /* programs.bash.enable = true; */

  /* home.file.".zshrc".source = ../configs/zsh/zshrc; */
  /* home.file.".aliases".source = ../configs/zsh/aliases; */
  programs.z-lua = {
    enable = true;
    enableAliases = true;
    enableZshIntegration = true;
    options = [ "enhanced" "once" "fzf" ];
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "OneHalfDark";
      italic-text = "always";
    };
  };

  programs.fzf =
    {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f";
      defaultOptions = [ "--height 60%" "--border" ];
      /* fileWidgetCommand = "fd --type f"; */
      /* fileWidgetOptions = [ "--preview 'head {}'" ]; */
      /* historyWidgetOptions = [ "--sort" "--exact" ]; */
      changeDirWidgetCommand = "fd --type d";
      tmux = {
        enableShellIntegration = true;
        shellIntegrationOptions = [ "-d 60%" ];
      };
    };
}
