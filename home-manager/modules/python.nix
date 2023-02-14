{ config, pkgs, libs, ... }: {
  # nixpkgs.config.permittedInsecurePackages = [
  #   "python3.10-poetry-1.2.2"
  # ];

  home.packages = with pkgs; [
    (python3.withPackages (ps:
      with ps; [
        ipython
        pip
        poetry
        pynvim
      ]))
  ];
}
