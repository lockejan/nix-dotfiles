{ config, pkgs, libs, ... }: {
  programs.git = {
    userName = "Jan Schmitt";
    signing.signByDefault = true;
    aliases = {
      br = "branch";
      branch-name = "!git rev-parse --abbrev-ref HEAD";
      bd = "branch -d";
      bdr = "push origin --delete";
      cm = "commit";
      cmns = "-c commit.gpgsign=false commit";
      cma = "commit --amend";
      co = "checkout";
      cob = "switch -c";
      di = "diff";
      ds = "diff --staged";
      fixup = "commit --amend --no-edit";
      history = "log --follow --patch";
      last = "log -n 1 --format=%H";
      lgo = "log --pretty=oneline";
      lgf =
        "log --graph --abbrev-commit --decorate --pretty=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)<%an>%C(reset)%n %C(dim black)%s%C(reset) %C(dim white) - %an%C(reset)' --all";
      lg =
        "log --graph --date=human --pretty=format:'%C(bold blue)%h %C(yellow)%d%Creset %s %Cgreen(%ad) %C(cyan)<%an>%Creset' --all";
      lg-fancier =
        "log --graph --pretty=format:'%C(yellow)%d%Creset %C(cyan)%h%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=short --all";
      praise = "blame";
      push-branch = "!git push -u origin $(git branch-name)";
      st = "status";
      sti = "status --ignored";
      unstage = "reset HEAD --";
      undo = "reset HEAD~1 --mixed";
      amend = "commit -a --amend";
      prv = "!gh pr view";
      prc = "!gh pr create";
      prs = "!gh pr status";
      prm = "!gh pr merge -d";
      nosub = "push --recurse-submodules=no";
    };
    extraConfig = {
      color = {
        ui = "auto";
        branch = "auto";
        diff = "auto";
        status = {
          added = "green";
          changed = "yellow";
          untracked = "blue";
        };
      };
      diff = {
        # tool = "nvimdiff";
        ansible-vault = {
          textconv =
            "ansible-vault view --vault-password-file=~/ansible-vault.sh";
        };
        mnemonicprefix = true;
      };
      # difftool = { path = "nvim"; };
      format = { pretty = "fuller"; };
      fetch = { prune = true; };
      help = { autocorrect = 10; };
      interactive = { singlekey = true; };
      merge = { tool = "nvim"; };
      mergetool = {
        nvim = {
          cmd =
            ''nvim -d -c "wincmd l" -c "norm ]c" "$LOCAL" "$MERGED" "$REMOTE"'';
        };
        prompt = true;
        keepBackup = false;
      };
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
      init = { defaultBranch = "main"; };
      pull = { rebase = true; };
      core = {
        editor = "nvim";
        # pager = "nvim -R";
        quotepath = false;
        excludesfile = "~/.ignore";
      };
      commit = { verbose = true; };
      rebase = { autoStash = true; };
      submodule = { recurse = true; };
      credential.helper = "osxkeychain";
    };
  };
  home.file.".ignore".source = ../configs/git/ignore;
  home.file.".gitignore".source = ../configs/git/gitignore;
  xdg.configFile."git/attributes".source = ../configs/git/attributes;

  home.packages = with pkgs; [ git-crypt git-filter-repo git-trim gh ];
}
