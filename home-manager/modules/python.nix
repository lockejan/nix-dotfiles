{ pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{

  home.packages = with unstable; [
    (python3.withPackages (ps:
      with ps; [
        ipython
        pip
        poetry-core
        pynvim
        # python-lsp-server
        ruff-lsp
      ]))
  ];
}
