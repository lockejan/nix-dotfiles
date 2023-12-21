{ nixpkgs-unstable, ... }:
{ config, pkgs, ... }:
let
  unstable = nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  home.packages = with pkgs; [
    black
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
    graphviz
    # haskell-language-server
    hlint
    stylish-haskell
    lua
    # neovim-nightly
    unstable.neovim
    nil
    nixfmt
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.eslint
    # nodePackages.intelephense
    nodePackages.pyright
    nodePackages.typescript
    nodePackages.typescript-language-server
    # nodePackages.vim-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    unstable.nodejs_20
    # omnisharp-roslyn
    # python39Packages.python-lsp-server
    rust-analyzer
    rustc
    # rnix-lsp
    # rubyPackages.solargraph
    shfmt
    statix
    stylua
    sumneko-lua-language-server
    terraform-ls
    unstable.texlab
    yamllint
    yapf
    (yarn.override { nodejs = unstable.nodejs_20; })
  ];
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager/configs/nvim";
}
