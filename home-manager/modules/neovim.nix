{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    clojure
    clojure-lsp
    cargo
    # dotnet-sdk
    elmPackages.elm
    elmPackages.elm-test
    elmPackages.elm-format
    elmPackages.elm-language-server
    glow
    gopls
    # haskell-language-server
    hlint
    stylish-haskell
    lua
    # neovim-nightly
    neovim
    nixfmt
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.eslint
    # nodePackages.intelephense
    nodePackages.pyright
    nodePackages.typescript-language-server
    # nodePackages.vim-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    nodejs
    # omnisharp-roslyn
    python39Packages.python-lsp-server
    rust-analyzer
    rustc
    rnix-lsp
    # rubyPackages.solargraph
    shfmt
    statix
    stylua
    sumneko-lua-language-server
    yamllint
    yapf
    yarn
  ];
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager/configs/nvim";
}
