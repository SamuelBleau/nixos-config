{ config, pkgs, theme, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Layer rules for UI elements
    layerrule = [
      "blur,waybar"
      "blur,wofi" 
      "blur,mako"
      "ignorezero,waybar"
      "ignorezero,wofi"
      "ignorezero,mako"
    ];
  };

  # Use extraConfig for all window rules with v2 syntax
  wayland.windowManager.hyprland.extraConfig = ''
    # Basic window opacity and behavior rules
    windowrulev2 = opacity 0.9 0.8,class:^(kitty)$
    windowrulev2 = opacity 0.9 0.8,class:^(alacritty)$
    windowrulev2 = opacity 0.95 0.9,class:^(nautilus)$
    windowrulev2 = opacity 0.98 0.95,class:^(code)$
    windowrulev2 = opacity 0.98 0.95,class:^(vscodium)$
    
    # Media players
    windowrulev2 = float,class:^(mpv)$
    windowrulev2 = size 800 600,class:^(mpv)$
    windowrulev2 = center,class:^(mpv)$
    
    # System dialogs
    windowrulev2 = float,class:^(pavucontrol)$
    windowrulev2 = size 600 400,class:^(pavucontrol)$
    windowrulev2 = center,class:^(pavucontrol)$
    
    # Screenshots tools
    windowrulev2 = float,class:^(flameshot)$
    windowrulev2 = float,class:^(spectacle)$
    
    # Browser windows
    windowrulev2 = opacity 0.95 0.85,class:^(firefox)$
    windowrulev2 = workspace 2,class:^(firefox)$
    
    # Terminal assignments  
    windowrulev2 = workspace 1,class:^(kitty)$
    windowrulev2 = workspace 1,class:^(alacritty)$
    
    # Development workspace
    windowrulev2 = workspace 3,class:^(code)$
    windowrulev2 = workspace 3,class:^(vscodium)$
    
    # Communication
    windowrulev2 = workspace special:magic,class:^(discord)$
    windowrulev2 = float,class:^(pavucontrol)$
    windowrulev2 = float,class:^(nm-connection-editor)$
    windowrulev2 = float,class:^(blueman-manager)$
    windowrulev2 = float,class:^(thunar)$,title:^(File Operation Progress)$
    
    # Workspace assignments
    # windowrulev2 = workspace 1,class:^(kitty)$
    # Advanced window rules for specific apps
    windowrulev2 = float,class:^(nm-connection-editor)$
    windowrulev2 = float,class:^(blueman-manager)$
    windowrulev2 = float,class:^(thunar)$,title:^(File Operation Progress)$
    
    # Workspace assignments for special apps
    windowrulev2 = workspace 4,class:^(deezer-enhanced)$
    
    # Special window behaviors
    windowrulev2 = float,title:^(Picture-in-Picture)$
    windowrulev2 = pin,title:^(Picture-in-Picture)$
    windowrulev2 = size 400 225,title:^(Picture-in-Picture)$
    windowrulev2 = move 1510 845,title:^(Picture-in-Picture)$
    
    # Deezer rules
    windowrulev2 = size 1200 800,class:^(deezer-enhanced)$
    windowrulev2 = center,class:^(deezer-enhanced)$

    # Gaming rules
    windowrulev2 = fullscreen,class:^(steam_app_).*
    windowrulev2 = workspace 8,class:^(steam)$
    windowrulev2 = workspace 8,class:^(lutris)$
    
    # Wofi configuration
    windowrulev2 = float,class:^(wofi)$
    windowrulev2 = size 600 400,class:^(wofi)$
    windowrulev2 = center,class:^(wofi)$
    windowrulev2 = animation popin 80%,class:^(wofi)$
    
    # Security
    windowrulev2 = fullscreen,class:^(swaylock)$
    
    # System monitoring
    windowrulev2 = float,class:^(htop)$
    windowrulev2 = float,class:^(btop)$
    windowrulev2 = size 1000 700,class:^(htop)$
    windowrulev2 = size 1000 700,class:^(btop)$
    windowrulev2 = center,class:^(htop)$
    windowrulev2 = center,class:^(btop)$
    
    # Notifications
    windowrulev2 = float,class:^(mako)$
    windowrulev2 = noborder,class:^(mako)$
    
    # Suppress unwanted events
    windowrulev2 = suppressevent maximize,class:.*
  '';
}