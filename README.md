# nix-dotfiles

These are my personal nix-dotfiles.
Use at your own risk.

It's still very much work in progress.

## Install

1. Install [nix](https://nixos.org/guides/install-nix.html) on your machine or via docker.

2. Install [home-manager](https://github.com/nix-community/home-manager).

3. Clone repository and run (setup.sh)[./setup.sh] to symlink the repo into the proper place.
During home-manager installation a nixpkgs folder has already been created in the target dir.
Inspect it, make a backup or delete it.

4. Run `home-manager switch` to install the dotfiles.

## Machine specific extras

Right now additional specific and sensitive information are pulled in via a private submodule.

These live under the folder `machines` and get included inside [home.nix](./nixpkgs/home.nix).

Especially git and additional tooling is pulled in via such. To create your own you can use this example code as a start for a `personal.nix`:

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
- [ ] properly registering gui apps
