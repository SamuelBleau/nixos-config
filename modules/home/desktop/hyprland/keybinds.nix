{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    
    bind = [
      # Applications
      "$mod, Return, exec, kitty"
      "$mod, T, exec, kitty"
      "$mod, D, exec, pkill -x wofi || rat-wofi"  # Use custom rat script
      "$mod, Space, exec, pkill -x wofi || rat-wofi"  # Use custom rat script
      "$mod, B, exec, firefox"
      "$mod, E, exec, nautilus"

      # Window management
      "$mod, Q, killactive"
      "$mod, F, fullscreen"
      "$mod, V, togglefloating"
      "$mod, P, pseudo"
      "$mod, J, togglesplit"

      # Focus
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      # Navigate workspaces horizontally
      "$mod ALT, left, workspace, e-1"    # Workspace précédent (gauche)
      "$mod ALT, right, workspace, e+1"   # Workspace suivant (droite)
      "$mod, Page_Up, workspace, e-1"     # Alternative: Page Up
      "$mod, Page_Down, workspace, e+1"   # Alternative: Page Down

      # Force horizontal splits
      "$mod SHIFT, H, layoutmsg, preselect l"
      "$mod SHIFT, L, layoutmsg, preselect r"

      # Resize
      "$mod CTRL, left, resizeactive, -20 0"
      "$mod CTRL, right, resizeactive, 20 0"
      "$mod CTRL, up, resizeactive, 0 -20"
      "$mod CTRL, down, resizeactive, 0 20"

      # Move windows
      "$mod SHIFT, left, movewindow, l"
      "$mod SHIFT, right, movewindow, r"
      "$mod SHIFT, up, movewindow, u"
      "$mod SHIFT, down, movewindow, d"

      # Workspaces (AZERTY keyboard layout)
      "$mod, ampersand, workspace, 1"      # Touche &
      "$mod, eacute, workspace, 2"         # Touche é
      "$mod, quotedbl, workspace, 3"       # Touche "
      "$mod, apostrophe, workspace, 4"     # Touche '
      "$mod, parenleft, workspace, 5"      # Touche (
      "$mod, minus, workspace, 6"          # Touche -
      "$mod, egrave, workspace, 7"         # Touche è
      "$mod, underscore, workspace, 8"     # Touche _
      "$mod, ccedilla, workspace, 9"       # Touche ç
      "$mod, agrave, workspace, 10"        # Touche à

      # Move to workspace (AZERTY keyboard layout)
      "$mod SHIFT, ampersand, movetoworkspace, 1"      # Shift + &
      "$mod SHIFT, eacute, movetoworkspace, 2"         # Shift + é
      "$mod SHIFT, quotedbl, movetoworkspace, 3"       # Shift + "
      "$mod SHIFT, apostrophe, movetoworkspace, 4"     # Shift + '
      "$mod SHIFT, parenleft, movetoworkspace, 5"      # Shift + (
      "$mod SHIFT, minus, movetoworkspace, 6"          # Shift + -
      "$mod SHIFT, egrave, movetoworkspace, 7"         # Shift + è
      "$mod SHIFT, underscore, movetoworkspace, 8"     # Shift + _
      "$mod SHIFT, ccedilla, movetoworkspace, 9"       # Shift + ç
      "$mod SHIFT, agrave, movetoworkspace, 10"        # Shift + à

      # Music Inputs :
      "$mod, M, exec, deezer-enhanced"  # Version native au lieu de Flatpak
      "$mod, A, exec, playerctl play-pause"

      # Special workspaces
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"

      # Navigation between workspaces
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

      # Screenshots
      ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
      "$mod, Print, exec, grim - | wl-copy"
      "$mod SHIFT, S, exec, grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +'%Y%m%d_%H%M%S').png"

      # Audio controls with F keys
      ", F5, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", F6, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", F7, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      
      # Brightness controls with F keys
      ", F2, exec, brightnessctl set 5%-"
      ", F3, exec, brightnessctl set 5%+"
      
      # Media controls (standard keys)
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"

      # System controls
      "$mod SHIFT, E, exec, /home/meeast/.config/hypr/cleanup.sh && hyprctl dispatch exit"
      "$mod SHIFT, R, exec, hyprctl reload"
      "$mod SHIFT, L, exec, loginctl lock-session"
      "$mod, L, exec, swaylock --color 1a1625 --inside-color 8b5cf6 --ring-color a855f7 --key-hl-color c084fc --text-color e4e4e7 --indicator-radius 100 --indicator-thickness 10 --effect-blur 7x5 --effect-vignette 0.2:0.5 --fade-in 0.5"
      
      # Wallpaper controls - Cyberpunk glitch effects
      "$mod, W, exec, /etc/nixos/assets/scripts/cyberpunk-wallpaper.sh"  # Cycle: Lucy → City → Car → Lucy...
    ];

    # Mouse bindings
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
