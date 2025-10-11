# Home Manager configuration for user meeast
{ config, pkgs, lib, theme, ... }:

{
  imports = [
    ./options.nix
    ./desktop.nix
    ./development.nix
    ./terminal.nix
  ];
  
  # Enable features
  meeast = {
    desktop.enable = true;
    desktop.hyprland.enable = true;
    desktop.waybar.enable = true;
    development.enable = true;
    development.vscode.enable = true;
    development.git.enable = true;
  };
  
  home = {
    username = "meeast";
    homeDirectory = "/home/meeast";
    stateVersion = "24.05";
  };
  
  programs.home-manager.enable = true;
}
