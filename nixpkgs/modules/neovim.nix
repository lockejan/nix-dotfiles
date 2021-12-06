{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    neovim-nightly
    clojure-lsp
    rnix-lsp
    nodePackages.vscode-langservers-extracted
    nodePackages.pyright
    nodePackages.bash-language-server
    nodePackages.intelephense
    nodePackages.yaml-language-server
    nodePackages.dockerfile-language-server-nodejs
  ];
}
