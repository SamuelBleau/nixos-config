{ config, pkgs, ... }:

{
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
  services.upower.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
