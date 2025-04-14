{ pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  home.packages = with unstable; [ ssh-audit sshpass mosh ];

  programs.ssh = {
    enable = true;
    compression = true;
    controlMaster = "auto";
    controlPath = "/tmp/ssh_mux_%h_%p_%r";
    controlPersist = "10m";
    forwardAgent = true;
    hashKnownHosts = false;
    addKeysToAgent = "yes";
    # includes = [ "hosts" ];
    extraConfig = ''
      # AddKeysToAgent yes
      UseKeychain yes
    '';

  };

}
