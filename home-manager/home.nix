{ config, pkgs, pkgsUnstable, username, stateVersion, ... }:
let
  user = username;
in
{
  home = {

    # home.username = builtins.getEnv "USER";
    # home.homeDirectory = builtins.getEnv "HOME";
    username = user;
    homeDirectory = "/Users/${user}";

    inherit stateVersion;

    packages = with pkgsUnstable; [
      # cachix
      # google-java-format
      jdk
      # mob
      # ncdu
      # niv
      # nix-doc
      # page
      # solo2-cli
      # vagrant
      babashka
      coreutils-full
      claude-code
      ctop
      curl
      dockutil
      doggo # dns client
      entr # watch files for changes
      exif # show exif data
      fd # find alternative
      fzf-git-sh
      geckodriver
      # glances
      gnugrep
      hexyl # cli hex viewer
      htop
      hyperfine # time alternative
      ijq
      inetutils # telnet, ftp, etc
      jq
      less
      ncurses
      nix-prefetch-git
      nix-tree
      nix-update
      nixpkgs-fmt
      nixpkgs-review
      openssl
      pwgen
      # renovate
      ripgrep
      tldr
      trash-cli
      watch
      wget
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "$EDITOR";
      # PAGER = "nvim -R";
      # MANPAGER = "nvim +Man!";
      LESS = "-R --use-color Du+b";
      # MANPAGER="less -R --use-color -Dd+r -Du+b";
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#808080";
      # FZF_CTRL_T_OPTS = "--preview 'bat --color=always --style=numbers --line-range=:500 {}'";
    };

    file.".ideavimrc".source =
      config.lib.file.mkOutOfStoreSymlink ./configs/idea/ideavimrc;

    file.".hammerspoon".source =
      config.lib.file.mkOutOfStoreSymlink ./configs/hammerspoon;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';
}
