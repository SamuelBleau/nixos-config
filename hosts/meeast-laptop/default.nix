# Main configuration for meeast-laptop
{ config, pkgs, lib, theme, ... }:

{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}