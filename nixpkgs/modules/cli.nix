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
  /*   enableCompletion = true; */
  /*   /1* enableBashCompletion = false; *1/ */
  /*   /1* promptInit = ""; *1/ */
  /* }; */
  /* programs.zsh.initExtra = builtins.readFile ./configs/zsh/zshrc.zsh; */
  programs.bash.enable = true;

  home.file.".zshrc".source = ../configs/zsh/zshrc;
  home.file.".aliases".source = ../configs/zsh/aliases;

  programs.fzf =
    {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f";
      defaultOptions = [ "--height 40%" "--border" ];
      /* fileWidgetCommand = "fd --type f"; */
      fileWidgetOptions = [ "--preview 'head {}'" ];
      historyWidgetOptions = [ "--sort" "--exact" ];
      changeDirWidgetCommand = "fd --type d";
      tmux = {
        enableShellIntegration = true;
        shellIntegrationOptions = [ "-d 40%" ];
      };
    };
}
