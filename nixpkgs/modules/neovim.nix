{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    clojure-lsp
    glow
    gopls
    haskell-language-server
    lua
    neovim-nightly
    nixfmt
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.eslint
    nodePackages.intelephense
    nodePackages.pyright
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    nodejs
    rnix-lsp
    rubyPackages.solargraph
    shfmt
    stylua
    sumneko-lua-language-server
    yamllint
    yapf
    yarn
  ];
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink ../configs/nvim;
}
