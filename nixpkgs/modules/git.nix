{ config, pkgs, libs, ... }:
{
  programs.git = {
    /* package = pkgs.gitAndTools.gitFull; */
    enable = true;
    userEmail = "personal@example.de";
    userName = "Jan Schmitt";
    signing.key = "A2BC3C6F14351991";
    signing.signByDefault = true;
    aliases = {
      br = "branch";
      branch-name = "!git rev-parse --abbrev-ref HEAD";
      bd = "branch -d";
      bdr = "push origin --delete";
      cm = "commit";
      cma = "commit --amend";
      co = "checkout";
      cob = "switch -c";
      di = "diff";
      ds = "diff --staged";
      history = "log --follow --patch";
      last = "log -n 1 --format=%H";
      lgo = "log --pretty=oneline";
      lgf = "log --graph --abbrev-commit --decorate --pretty=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)<%an>%C(reset)%n %C(dim black)%s%C(reset) %C(dim white) - %an%C(reset)' --all";
      lg = "log --graph --date=human --pretty=format:'%C(bold blue)%h %C(yellow)%d%Creset %s %Cgreen(%ad) %C(cyan)<%an>%Creset' --all";
      lg-fancier = "log --graph --pretty=format:'%C(yellow)%d%Creset %C(cyan)%h%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=short --all";
      praise = "blame";
      push-branch = "!git push -u origin $(git branch-name)";
      st = "status";
      unstage = "reset HEAD --";
      undo = "reset HEAD~1 --mixed";
      amend = "commit -a --amend";
      prv = "!gh pr view";
      prc = "!gh pr create";
      prs = "!gh pr status";
      prm = "!gh pr merge -d";
    };
    extraConfig = {
      color = {
        ui = "auto";
        branch = "auto";
        diff = "auto";
        /* status = "auto"; */
        status = {
          added = "green";
          changed = "yellow";
          untracked = "blue";
        };
      };
      diff = {
        tool = "vimdiff3";
        ansible-vault = "ansible-vault view --vault-password-file=~/ansible-vault.lua";
        /* mnemonicprefix = true; */
      };
      difftool = {
        path = "nvim";
      };
      format = {
        pretty = "fuller";
      };
      fetch = {
        prune = true;
      };
      merge = {
        tool = "vimdiff3";
        conflictstyle = "diff3";
      };
      /* push = { */
      /*   default = "simple"; */
      /* }; */
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      core = {
        editor = "nvim";
        pager = "diff-so-fancy | less --tabs=4 -RFX";
        quotepath = false;
        excludesfile = "~/.ignore";
      };
      commit = {
        verbose = true;
      };
      rebase = {
        autostash = true;
      };
      submodule = {
        recurse = true;
      };
    };
  };
  home.file.".ignore".source = ../configs/git/ignore;
}
