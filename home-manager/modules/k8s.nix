{ pkgs, inputs, ... }:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
  inherit (inputs.nix-kubectl-gs.packages.${pkgs.system}) kubectl-gs;
in

{
  home.packages = with unstable; [
    act
    colima
    docker
    docker-buildx
    docker-compose
    dive
    fluxcd
    kubectl
    kubectl-gs
    kubecolor
    kubernetes-helm
    minikube
  ];

}
