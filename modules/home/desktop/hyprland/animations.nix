{ config, pkgs, lib, ... }:

with lib;

{
  wayland.windowManager.hyprland.settings = {
    animations = mkIf config.meeast.desktop.hyprland.animations.enable {
      enabled = true;
      bezier = [
        "ratSmooth, 0.23, 1, 0.32, 1"
        "ratOut, 0.76, 0, 0.24, 1"
        "ratBounce, 0.175, 0.885, 0.32, 1.275"
        "easeInOut, 0.42, 0, 0.58, 1"
      ];

      animation = [
        # Windows - Fast but smooth scurrying motion (like a rat)
        "windows, 1, 4, ratSmooth"
        "windowsIn, 1, 4, ratSmooth, slide"
        "windowsOut, 1, 3, ratOut, slide"
        "windowsMove, 1, 4, ratSmooth"

        # Workspaces - Smooth horizontal sliding
        "workspaces, 1, 5, ratSmooth, slide"
        
        # Fade effects - Quick in the dark
        "fade, 1, 3, ratSmooth"
        
        # Special workspace
        "specialWorkspace, 1, 5, ratBounce, slide"
        
        # Border animations
        "border, 1, 5, easeInOut"
        "borderangle, 1, 8, easeInOut, loop"
      ];
    };

    layerrule = [
      "animation slide, waybar"
      "animation popin 80%, wofi"
      "animation slide top, mako"
    ];
  };
}
