{ config, pkgs, ... }:

let
  cyberpunk = import ../../themes/cyberpunk/colors.nix;
in
{
  wayland.windowManager.hyprland.settings = {
    # General appearance with cyberpunk styling
    general = {
      gaps_in = 8;
      gaps_out = 24;
      border_size = 3;
      "col.active_border" = "rgba(${builtins.substring 1 6 cyberpunk.primary.cyan}ff) rgba(${builtins.substring 1 6 cyberpunk.primary.magenta}ff) 45deg";
      "col.inactive_border" = "rgba(${builtins.substring 1 6 cyberpunk.ui.border_inactive}aa)";
      layout = "dwindle";
      allow_tearing = false;
      resize_on_border = true;
      extend_border_grab_area = 15;
      hover_icon_on_border = true;
    };

    # Decoration with cyberpunk glow effects
    decoration = {
      rounding = 12;
      
      blur = {
        enabled = true;
        size = 4;
        passes = 2;
        vibrancy = 0.3;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.02;
        new_optimizations = true;
        xray = false;
        ignore_opacity = false;
      };
      
      shadow = {
        enabled = true;
        range = 6;
        render_power = 4;
        color = cyberpunk.effects.shadow;
        color_inactive = "${cyberpunk.ui.background}88";
        sharp = false;
        offset = "0 2";
        scale = 1.0;
      };
      
      # Window opacity for cyberpunk aesthetic
      active_opacity = 1.0;
      inactive_opacity = 0.85;
      fullscreen_opacity = 1.0;
      
      # Drop shadow for floating windows
      drop_shadow = true;
      
      # Dim inactive windows slightly
      dim_inactive = false;
      dim_strength = 0.1;
      dim_special = 0.2;
      dim_around = 0.4;
    };

    # Dwindle layout configuration
    dwindle = {
      pseudotile = true;
      preserve_split = true;
      smart_split = false;
      smart_resizing = true;
      force_split = 0;
      split_width_multiplier = 1.0;
      no_gaps_when_only = false;
      use_active_for_splits = true;
      default_split_ratio = 1.0;
    };

    # Master layout (alternative)
    master = {
      new_status = "master";
      new_on_top = false;
      no_gaps_when_only = false;
      orientation = "left";
      inherit_fullscreen = true;
      always_center_master = false;
      smart_resizing = true;
      drop_at_cursor = true;
      mfact = 0.55;
    };

    # Group configuration for window grouping
    group = {
      "col.border_active" = "rgba(${builtins.substring 1 6 cyberpunk.primary.cyan}ff)";
      "col.border_inactive" = "rgba(${builtins.substring 1 6 cyberpunk.ui.border_inactive}aa)";
      "col.border_locked_active" = "rgba(${builtins.substring 1 6 cyberpunk.primary.yellow}ff)";
      "col.border_locked_inactive" = "rgba(${builtins.substring 1 6 cyberpunk.ui.background}aa)";
      groupbar = {
        enabled = true;
        font_family = "JetBrains Mono";
        font_size = 10;
        gradients = true;
        height = 14;
        priority = 3;
        render_titles = true;
        scrolling = true;
        stacked = false;
        text_color = cyberpunk.text.primary;
        "col.active" = "rgba(${builtins.substring 1 6 cyberpunk.primary.cyan}ff)";
        "col.inactive" = "rgba(${builtins.substring 1 6 cyberpunk.ui.background}aa)";
        "col.locked_active" = "rgba(${builtins.substring 1 6 cyberpunk.primary.yellow}ff)";
        "col.locked_inactive" = "rgba(${builtins.substring 1 6 cyberpunk.ui.background}66)";
      };
    };

    # Debug overlay styling
    debug = {
      overlay = false;
      damage_blink = false;
      disable_logs = true;
      disable_time = true;
      damage_tracking = 2;
      enable_stdout_logs = false;
      manual_crash = 0;
      suppress_errors = false;
      watchdog_timeout = 5;
    };
  };
}