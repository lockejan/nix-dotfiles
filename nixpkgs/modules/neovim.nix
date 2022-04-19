{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    # clojure-lsp
    cargo
    dotnet-sdk
    glow
    gopls
    haskell-language-server
    hlint
    stylish-haskell
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
    omnisharp-roslyn
    rust-analyzer
    rustc
    rnix-lsp
    # rubyPackages.solargraph
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
