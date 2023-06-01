{ pkgs, ... }: {

  home.packages = with pkgs; [
    (python3.withPackages (ps:
      with ps; [
        ipython
        pip
        poetry-core
        pynvim
        python-lsp-server
      ]))
  ];
}
