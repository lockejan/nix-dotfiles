{ pkgs, inputs, ... }:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
  kubectl-gs = inputs.nix-kubectl-gs.packages.${pkgs.system}.kubectl-gs;
in

{
  home.packages = with pkgs; [
    colima
    docker
    docker-buildx
    docker-compose
    unstable.kubectl
    kubectl-gs
    unstable.kubecolor
    unstable.kubernetes-helm
    unstable.minikube
  ];

}
