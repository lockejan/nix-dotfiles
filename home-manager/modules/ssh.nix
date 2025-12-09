{ pkgs, pkgsUnstable, ... }:

{
  home.packages = with pkgsUnstable; [ ssh-audit sshpass mosh ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks."*" = {
      compression = true;
      controlMaster = "auto";
      controlPath = "/tmp/ssh_mux_%h_%p_%r";
      controlPersist = "10m";
      forwardAgent = true;
      hashKnownHosts = false;
      addKeysToAgent = "yes";
    };
    extraConfig = ''
      # AddKeysToAgent yes
      UseKeychain yes
    '';
  };

}
