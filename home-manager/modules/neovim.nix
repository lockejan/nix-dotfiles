{ config, pkgs, inputs, lib, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  home.packages = with pkgs; [
    # ansible-lint
    unstable.actionlint
    ansible-language-server
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
    unstable.neovim
    nil
    nixfmt-classic
    bash-language-server
    dockerfile-language-server-nodejs
    eslint
    # nodePackages.intelephense
    typescript
    typescript-language-server
    # nodePackages.vim-language-server
    unstable.vscode-langservers-extracted
    yaml-language-server
    lua51Packages.tiktoken_core
    unstable.nodejs_22
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
    unstable.texlab
    unstable.vue-language-server
    yamllint
    (yarn.override { nodejs = unstable.nodejs-slim; })
  ];
  home.activation.linkNeovimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -e ${config.home.homeDirectory}/.config/nvim ]; then
      ln -s ${config.home.homeDirectory}/dotfiles/home-manager/configs/nvim ${config.home.homeDirectory}/.config/nvim
    fi
  '';
}
