{ pkgs, pkgsUnstable, inputs, ... }:

let
  inherit (inputs.nix-kubectl-gs.packages.${pkgs.system}) kubectl-gs;
in

{
  home.packages = with pkgsUnstable; [
    act
    colima
    docker
    docker-buildx
    docker-compose
    dive
    fluxcd
    grype
    kubectl
    kubectl-gs
    kubecolor
    kubernetes-helm
    minikube
    trivy
  ];

}
