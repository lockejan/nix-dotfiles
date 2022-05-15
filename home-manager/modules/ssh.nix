{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [ ssh-audit sshpass openssh libfido2 ];
  # xdg.configfile.".ssh/config".source = ../configs/ssh/ssh_config;
  home.file.".ssh/config".text = ''
    HashKnownHosts no
    VerifyHostKeyDNS ask
    VisualHostKey no

    ControlMaster auto
    ControlPath /tmp/ssh_mux_%h_%p_%r

    Include hosts

    Host *
       AddKeysToAgent yes
       ForwardAgent yes
  '';
}
