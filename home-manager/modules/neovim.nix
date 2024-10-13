{ config, pkgs, inputs, ... }:
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
    elmPackages.elm
    elmPackages.elm-test
    elmPackages.elm-format
    elmPackages.elm-language-server
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
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.eslint
    # nodePackages.intelephense
    nodePackages.typescript
    nodePackages.typescript-language-server
    # nodePackages.vim-language-server
    unstable.nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    lua51Packages.tiktoken_core
    unstable.nodejs_20
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
    (yarn.override { nodejs = unstable.nodejs_20; })
  ];
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager/configs/nvim";
}
