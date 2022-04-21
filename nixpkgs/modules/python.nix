{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    poetry
    (python310.withPackages (ps: with ps; [ pip pynvim debugpy ]))
  ];
}
