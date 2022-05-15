# nix-dotfiles

These are my personal nix-dotfiles to setup my macOs machines.
Use at your own risk.

It's still very much work in progress.

## Install

1. Install [nix](https://nixos.org/guides/install-nix.html) on your machine.

2. Add [home-manager](https://github.com/nix-community/home-manager)-channel. This way it can be used as a [nix-darwin module](https://nix-community.github.io/home-manager/index.html#sec-install-nix-darwin-module).

3. Install [nix-darwin](https://github.com/LnL7/nix-darwin).

4. Clone the repository and run [setup.sh](./setup.sh) to symlink the repo into the proper place.

5. Run `darwin-rebuild switch` to install the dotfiles.

## Machine specific extras

Right now additional specific and sensitive information are provided via a private git submodule.

These live under the folder `machines` and get included inside [home.nix](./home-manager/home.nix).

Especially git configuration and additional tooling is pulled in via such.
This way each machine gets only what it needs.
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

## TODO

- [ ] handling secrets
- [X] machine specific configuration
- [X] properly registering gui apps
- [X] setup nix-darwin to add more darwin specific configuration
- [ ] setup flakes

## Questions?
Feel free to open issues if you’re interested in something.

## License
Consider dotfiles unlicensed ([https://unlicense.org/](https://unlicense.org)), do what you want with anything you want. Feel free to link back if you want, it could help others in the future but I don’t mind otherwise.
