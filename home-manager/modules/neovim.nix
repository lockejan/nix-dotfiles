{ config, pkgs, inputs, lib, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  home.packages = with unstable; [
    # ansible-lint
    actionlint
    pkgs.ansible-language-server
    black
    clojure
    # clojure-lsp
    cargo
    # dotnet-sdk
    # elmPackages.elm
    # elmPackages.elm-test
    # elmPackages.elm-format
    # elmPackages.elm-language-server
    glow
    go
    gopls
    graphviz
    # haskell-language-server
    hadolint
    hlint
    helm-ls
    stylish-haskell
    lua
    # neovim-nightly
    neovim
    nil
    nixfmt-classic
    bash-language-server
    dockerfile-language-server
    eslint
    # nodePackages.intelephense
    typescript
    typescript-language-server
    # nodePackages.vim-language-server
    vscode-langservers-extracted
    yaml-language-server
    lua51Packages.tiktoken_core
    nodejs_22
    # omnisharp-roslyn
    # python39Packages.python-lsp-server
    ruff
    rust-analyzer
    rustc
    # rnix-lsp
    # rubyPackages.solargraph
    shfmt
    statix
    stylua
    sumneko-lua-language-server
    terraform-ls
    texlab
    tree-sitter
    vue-language-server
    yamllint
    (yarn.override { nodejs = nodejs_22; })
  ];
  home.activation.linkNeovimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -e ${config.home.homeDirectory}/.config/nvim ]; then
      ln -s ${config.home.homeDirectory}/dotfiles/home-manager/configs/nvim ${config.home.homeDirectory}/.config/nvim
    fi
  '';
}
