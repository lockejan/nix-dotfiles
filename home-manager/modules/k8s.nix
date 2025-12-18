{ pkgs, pkgsUnstable, inputs, ... }:

let
  inherit (inputs.nix-kubectl-gs.packages.${pkgs.stdenv.hostPlatform.system}) kubectl-gs;
in

{
  home.packages = with pkgsUnstable; [
    act
    colima
    docker
    docker-buildx
    docker-compose
    docker-sbom
    docker-slim
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

  # Setup Docker CLI plugins
  # These enable running commands like: docker buildx, docker compose, docker sbom
  home.file = {
    ".docker/cli-plugins/docker-buildx".source = "${pkgsUnstable.docker-buildx}/bin/docker-buildx";
    ".docker/cli-plugins/docker-compose".source = "${pkgsUnstable.docker-compose}/bin/docker-compose";
    ".docker/cli-plugins/docker-sbom".source = "${pkgsUnstable.docker-sbom}/bin/docker-sbom";
  };

}
