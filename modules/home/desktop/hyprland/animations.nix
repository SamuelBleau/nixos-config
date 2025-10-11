{ config, pkgs, lib, ... }:

with lib;

{
  wayland.windowManager.hyprland.settings = {
    animations = mkIf config.meeast.desktop.hyprland.animations.enable {
      enabled = true;
      bezier = [
        "cyber, 0.23, 1, 0.32, 1"
        "cyberOut, 0.76, 0, 0.24, 1"
        "cyberSmooth, 0.25, 0.46, 0.45, 0.94"
        "elastic, 0.68, -0.55, 0.265, 1.55"
        "cyberFlat, 0.25, 0.0, 0.75, 1.0"
        "bounce, 0.175, 0.885, 0.32, 1.275"
        "easeInOut, 0.42, 0, 0.58, 1"
      ];

      animation = [
        # Windows - Sharp and responsive like cyberpunk interfaces
        "windows, 1, 6, cyber"
        "windowsIn, 1, 6, cyber, slide"
        "windowsOut, 1, 4, cyberOut, slide"
        "windowsMove, 1, 5, cyber"

        # Workspaces - Smooth horizontal sliding with cyberpunk feel
        "workspaces, 1, 7, cyberFlat, slide"
        
        # Fade effects - Quick and sharp
        "fade, 1, 4, cyber"
        "fadeIn, 1, 4, cyber"
        "fadeOut, 1, 3, cyberOut"
        
        # Special workspace with horizontal bounce effect (like quickhacks menu)
        "specialWorkspace, 1, 6, bounce, slide"
        
        # Border animations - Subtle glow effect
        "border, 1, 8, easeInOut"
        "borderangle, 1, 10, easeInOut, loop"
      ];
    };

    # Custom animation layers for specific elements
    layerrule = [
      # Waybar appears instantly (like HUD overlay)
      "animation slide, waybar"
      # Wofi (quickhacks menu) gets special bounce animation
      "animation popin 80%, wofi"
      # Notifications slide in from top (like cyberpunk alerts)
      "animation slide top, mako"
    ];
  };
}