{ pkgs, pkgsUnstable, ... }:

{
  home.packages = with pkgsUnstable; [ ssh-audit sshpass mosh ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."*" = {
      Compression = true;
      ControlMaster = "auto";
      ControlPath = "/tmp/ssh_mux_%h_%p_%r";
      ControlPersist = "10m";
      ForwardAgent = true;
      HashKnownHosts = false;
      AddKeysToAgent = "yes";
    };
    extraConfig = ''
      # AddKeysToAgent yes
      UseKeychain yes
    '';
  };

}
