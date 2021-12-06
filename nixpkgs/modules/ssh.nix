{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    ssh-audit
    ssh-copy-id
    sshpass
  ];
  /* xdg.configfile.".ssh/config".source = ../configs/ssh/ssh_config; */
}
