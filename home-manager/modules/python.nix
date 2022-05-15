{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    poetry
    (python39.withPackages (ps: with ps; [ pip pynvim ]))
  ];
}
