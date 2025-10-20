{ pkgs, pkgsUnstable, ... }:
{

  home.packages = with pkgsUnstable; [
    uv
    (python3.withPackages (ps:
      with ps; [
        ipython
        pip
        poetry-core
        pynvim
        # python-lsp-server
        # ruff-lsp
      ]))
  ];
}
