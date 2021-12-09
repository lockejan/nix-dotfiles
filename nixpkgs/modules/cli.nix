{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    zsh-fzf-tab
    zsh
    zsh-fast-syntax-highlighting
    zsh-autosuggestions
    zsh-z
    zsh-history
    zsh-completions
    zsh-powerlevel10k
  ];

  /* programs.zsh = { */
  /*   enable = true; */
  /*   /1* enableCompletion = true; *1/ */
  /*   /1* enableBashCompletion = false; *1/ */
  /*   /1* promptInit = ""; *1/ */
  /*   shellAliases = { */
  /*     update = '' */
  /*       nix-channel --update && home-manager switch && lsp-update */
  /*     ''; */
  /*     zc = "$EDITOR ~/.zshrc"; */
  /*     vc = "$EDITOR ~/.config/nvim/init.lua"; */
  /*     www = "python -m SimpleHTTPServer 8000"; */
  /*     /1* ls = "exa"; #-FGh"; *1/ */
  /*     /1* ll = "exa -l"; #FGh"; *1/ */
  /*     /1* la = "exa -la"; #FGh"; *1/ */
  /*     pubip = "dig +short myip.opendns.com @resolver1.opendns.com"; */
  /*     localip = '' */
  /*       ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1' */
  /*     ''; */
  /*     du = "du -cksh"; */
  /*     df = "df -h"; */
  /*     mkdir = "command mkdir -p"; */
  /*     ssh = "TERM=xterm-256color ssh"; */
  /*     /1* \$ =''; *1/ */
  /*     # use modern regex patterns for sed, i.e. "(one|two)", not "\(one\|two\)" */
  /*     sed = "sed -E"; */
  /*     lsp-update = '' */
  /*         cd ~/.cache/nvim/nlua/sumneko_lua && */
  /*       git pull && */
  /*       cd 3rd/luamake && */
  /*       compile/install.sh && */
  /*       cd ../.. && */
  /*       ./3rd/luamake/luamake rebuild && cd ''; */
  /*   }; */
  /* }; */
  /* programs.zsh.initExtra = builtins.readFile ./configs/zsh/zshrc.zsh; */
  programs.bash.enable = true;

  home.file.".zshrc".source = ../configs/zsh/zshrc;
  home.file.".aliases".source = ../configs/zsh/aliases;

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
