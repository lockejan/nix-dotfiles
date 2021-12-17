{ lib, config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    /* dotDir = ".config/zsh"; */
    enableAutosuggestions = true;
    enableCompletion = true;
    /* enableSyntaxHighlighting = true; */
    completionInit = "autoload -Uz compinit; compinit -u";
    defaultKeymap = "emacs";
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
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "585c089968caa1c904cbe926ff04a1be9e3d8f42";
          sha256 = "x+4C2u03RueNo6/ZXsueqmYoPIpDHnKAZXP5IiKsidE=";
        };
      }
      /* { */
      /*   name = "zsh-autosuggestions"; */
      /*   src = pkgs.fetchFromGitHub { */
      /*     owner = "zsh-users"; */
      /*     repo = "zsh-autosuggestions"; */
      /*     rev = "a411ef3e0992d4839f0732ebeb9823024afaaaa8"; */
      /*     sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w="; */
      /*   }; */
      /* } */
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "a677cf770cfce1e3668ba576fecfb7a14f4f39e2";
          sha256 = "Qf9AZ2DjO9QUyEF7QG8JtlBHjwHfINOJkrMfu7pipns=";
        };
      }
    ];

    history =
      {
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
        save = 10000;
        share = true;
        size = 10000;
      };

    shellAliases = {
      update = "nix-channel --update && home-manager switch && lsp-update";
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
      lsp-update = ''
        cd ~/.cache/nvim/nlua/sumneko_lua &&
        git pull &&
        cd 3rd/luamake &&
        compile/install.sh &&
        cd ../.. &&
        ./3rd/luamake/luamake rebuild && cd '';
      luamake = (builtins.getEnv "HOME" + "/.cache/nvim/nlua/sumneko_lua/3rd/luamake/luamake");
    };
    initExtra = builtins.readFile ../configs/zsh/zshrc;
  };

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
