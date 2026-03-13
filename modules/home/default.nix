# Global Home Manager modules entrypoint
{ config, pkgs, lib, theme, ... }:

{
  imports = [
    ./options.nix
    ./desktop.nix
    ./development.nix
    ./terminal.nix
  ];
  
  # Configuration globale de base pour l'utilisateur
  home = {
    username = "meeast";
    homeDirectory = "/home/meeast";
    stateVersion = "24.05";
  };
  
  programs.home-manager.enable = true;
}
