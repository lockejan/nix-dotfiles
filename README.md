# nix-dotfiles

These are my personal nix-dotfiles to setup my macOS machines.
Use at your own risk.

It's still very much work in progress.

## Code Status

[![CI](https://github.com/lockejan/nix-dotfiles/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/lockejan/nix-dotfiles/actions/workflows/test.yml)


## Install

1. Install [nix](https://nixos.org/guides/install-nix.html) on your machine.

2. Install [nix-darwin](https://github.com/LnL7/nix-darwin).

3. The first build needs to be made manually:

```shell
nix build '$HOME/dotfiles?submodules=1#darwinConfigurations.m1.system'
./result/sw/bin/darwin-rebuild switch --flake $HOME/dotfiles?submodules=1#m1
```

Consecutive runs can be done via

```shell
darwin-rebuild switch --flake "$HOME/dotfiles?submodules=1#m1"
```

## Machine specific extras

Neovim configuration is currently pulled in via git submodule.

Additional sensitive information are encrypted with git-crypt.

These live under the folder `machines` and get included inside [flake.nix](./flake.nix).
To create your own you can use this example code as a start for a `personal.nix`:

```nix
{ config, pkgs, ... }: {

  # enable git and add email and gpg-key to the rest of the config
  programs.git = {
    enable = true;
    userEmail = "home@example.de";
    signing.key = "your-key-id";
  };

  # install a list of additional packages
  home.packages = with pkgs; [
    foo-package
  ];

  # add multiline information to hosts file
  home.file.".ssh/hosts".text = ''
    Host example-host
      Hostname 127.0.0.1
      User foo
  '';

}
```

## Further Resources and inspiration

- [malob's dotfiles](https://github.com/malob/nixpkgs)
- [nix.dev](https://nix.dev)
- [nix book](https://book.divnix.com/ch00-00-the-nix-package-manager.html)
- [nix pills](https://nixos.org/guides/nix-pills/index.html)
- [nix-tutorial](https://nix-tutorial.gitlabpages.inria.fr/nix-tutorial/index.html)
- [nix manual](https://nixos.org/manual/nix/stable/introduction.html)

## TODO

- [X] handling secrets &rarr; git-crypt
- [X] machine specific configuration
- [X] properly registering gui apps &rarr; homebrew until nix takes over
- [X] setup nix-darwin to add more darwin specific configuration
- [X] setup flakes

## Questions?
Feel free to open issues if you’re interested in something.

## License
Consider dotfiles unlicensed ([https://unlicense.org/](https://unlicense.org)), do what you want with anything you want. Feel free to link back if you want, it could help others in the future but I don’t mind otherwise.
