{ config, pkgs, theme, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # General appearance with Rat styling
    general = {
      gaps_in = 8;
      gaps_out = 24;
      border_size = 2; # Tighter borders for Rat theme
      "col.active_border" = "rgba(${builtins.substring 1 6 theme.primary.purple}ff) rgba(${builtins.substring 1 6 theme.primary.purpleDark}ff) 45deg";
      "col.inactive_border" = "rgba(${builtins.substring 1 6 theme.ui.border_inactive}aa)";
      layout = "dwindle";
      allow_tearing = false;
      resize_on_border = true;
      extend_border_grab_area = 15;
      hover_icon_on_border = true;
    };

    # Decoration
    decoration = {
      rounding = 8; # Less rounded than cyberpunk, more rugged
      
      blur = {
        enabled = true;
        size = 5;
        passes = 3; # Deeper blur for a murky/sewer feel
        vibrancy = 0.1;
        brightness = 0.9;
        contrast = 0.9;
        noise = 0.05; # Slightly more noise for the dirty underground feel
        new_optimizations = true;
        xray = false;
        ignore_opacity = false;
      };
      
      shadow = {
        enabled = true;
        range = 10;
        render_power = 3;
        color = theme.effects.shadow;
        color_inactive = "${theme.ui.background}88";
        sharp = false;
        offset = "0 3";
        scale = 1.0;
      };
      
      active_opacity = 0.95;
      inactive_opacity = 0.80;
      fullscreen_opacity = 1.0;
      
      dim_inactive = true; # Darken inactive windows for focus
      dim_strength = 0.2;
      dim_special = 0.3;
      dim_around = 0.4;
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
      smart_split = false;
      smart_resizing = true;
      force_split = 0;
      split_width_multiplier = 1.0;
      use_active_for_splits = true;
      default_split_ratio = 1.0;
    };

    master = {
      new_status = "master";
      new_on_top = false;
      orientation = "left";
      inherit_fullscreen = true;
      always_center_master = false;
      smart_resizing = true;
      drop_at_cursor = true;
      mfact = 0.55;
    };

    group = {
      "col.border_active" = "rgba(${builtins.substring 1 6 theme.primary.purple}ff)";
      "col.border_inactive" = "rgba(${builtins.substring 1 6 theme.ui.border_inactive}aa)";
      "col.border_locked_active" = "rgba(${builtins.substring 1 6 theme.primary.gray}ff)";
      "col.border_locked_inactive" = "rgba(${builtins.substring 1 6 theme.ui.background}aa)";
      groupbar = {
        enabled = true;
        font_family = "Hack Nerd Font";
        font_size = 10;
        gradients = true;
        height = 14;
        priority = 3;
        render_titles = true;
        scrolling = true;
        stacked = false;
        text_color = theme.text.primary;
        "col.active" = "rgba(${builtins.substring 1 6 theme.primary.purple}ff)";
        "col.inactive" = "rgba(${builtins.substring 1 6 theme.ui.background}aa)";
        "col.locked_active" = "rgba(${builtins.substring 1 6 theme.primary.gray}ff)";
        "col.locked_inactive" = "rgba(${builtins.substring 1 6 theme.ui.background}66)";
      };
    };

    debug = {
      disable_logs = true;
      disable_time = true;
      damage_tracking = 2;
    };
  };
}
