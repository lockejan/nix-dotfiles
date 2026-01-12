{ config, pkgs, pkgsUnstable, lib, ... }:
let
  # Core packages (always installed)
  corePackages = with pkgsUnstable; [
    neovim
    tree-sitter
    glow # Markdown renderer
    graphviz # Diagram rendering
  ];

  # Lua language (always enabled for Neovim config)
  luaPackages = with pkgsUnstable; [
    lua
    lua51Packages.tiktoken_core # For Copilot
    stylua
    lua-language-server
  ];

  goPackages = with pkgsUnstable; [
    go
    gopls
  ];

  rustPackages = with pkgsUnstable; [
    cargo
    rustc
    rust-analyzer
  ];

  pythonPackages = with pkgsUnstable; [
    black
    ruff
    basedpyright
  ];

  webPackages = with pkgsUnstable; [
    nodejs_22
    (yarn.override { nodejs = nodejs_22; })
    typescript
    typescript-language-server
    vue-language-server
    vscode-langservers-extracted # html, css, json, eslint LSPs
    eslint
  ];

  nixPackages = with pkgsUnstable; [
    nil
    nixfmt
    statix
  ];

  shellPackages = with pkgsUnstable; [
    bash-language-server
    shfmt
  ];

  devopsPackages = with pkgsUnstable; [
    dockerfile-language-server
    hadolint
    helm-ls
    terraform-ls
    yaml-language-server
    yamllint
    yamlfmt
    pkgs.actionlint # GitHub Actions linter
  ];

  latexPackages = with pkgsUnstable; [
    texlab
  ];

  clojurePackages = with pkgsUnstable; [
    clojure
    clojure-lsp
  ];

  haskellPackages = with pkgsUnstable; [
    haskell-language-server
    hadolint
    hlint
    stylish-haskell
  ];

  dotnetPackages = with pkgsUnstable; [
    dotnet-sdk
    omnisharp-roslyn
  ];

  elmPackages = with pkgsUnstable; [
    elmPackages.elm
    elmPackages.elm-test
    elmPackages.elm-format
    elmPackages.elm-language-server
  ];

in
{
  home.packages =
    corePackages
    # ++ clojurePackages
    ++ devopsPackages
    # ++ dotnetPackages
    # ++ elmPackages
    ++ goPackages
    # ++ haskellPackages
    # ++ latexPackages
    ++ luaPackages
    ++ nixPackages
    ++ pythonPackages
    ++ rustPackages
    ++ shellPackages
    ++ webPackages;

  home.activation.linkNeovimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -e ${config.home.homeDirectory}/.config/nvim ]; then
      ln -s ${config.home.homeDirectory}/dotfiles/home-manager/configs/nvim ${config.home.homeDirectory}/.config/nvim
    fi
  '';
}
