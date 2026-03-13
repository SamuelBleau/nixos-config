{ config, pkgs, lib, theme, ... }:

{
  imports = [
    ../../modules/home
  ];
  
  # Configuration spécifique à cette machine pour Home Manager
  meeast = {
    desktop.enable = true;
    desktop.hyprland.enable = true;
    desktop.waybar.enable = true;
    desktop.theme = "rat";
    development.enable = true;
    development.vscode.enable = true;
    development.git.enable = true;
  };
}
