{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [ ssh-audit sshpass openssh mosh ];

  programs.ssh = {
    enable = true;
    compression = true;
    controlMaster = "auto";
    controlPath = "/tmp/ssh_mux_%h_%p_%r";
    controlPersist = "10m";
    forwardAgent = true;
    hashKnownHosts = false;
    # addKeysToAgent = "yes";
    # includes = [ "hosts" ];
    extraConfig = ''
      addKeysToAgent = yes
    '';

  };

}
