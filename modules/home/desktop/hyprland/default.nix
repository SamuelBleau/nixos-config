{ config, pkgs, lib, theme, ... }:

with lib;

{
  imports = [
    ./keybinds.nix
    ./rules.nix
    ./animations.nix
    ./startup.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      monitor = [ ",preferred,auto,1" ];

      general = {
        gaps_in = config.meeast.desktop.hyprland.gaps.inner;
        gaps_out = config.meeast.desktop.hyprland.gaps.outer;
        border_size = config.meeast.desktop.hyprland.borderSize;
        "col.active_border" = "rgba(${builtins.substring 1 6 theme.primary.cyan}ff)";
        "col.inactive_border" = "rgba(00000000)";
        layout = "dwindle";
        allow_tearing = true;
      };

      # Decoration with cyberpunk effects
      decoration = {
        rounding = 12;
        
        blur = {
          enabled = true;
          size = 4;
          passes = 2;
          vibrancy = 0.3;
        };
      };

      # Input configuration
      input = {
        kb_layout = "fr";
        
        follow_mouse = 1;
        accel_profile = "flat";
        force_no_accel = false;
        natural_scroll = true;
        scroll_method = "2fg";
        
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          tap-to-click = true;
          scroll_factor = 1.0;
        };

        sensitivity = 0;
        mouse_refocus = true;
        special_fallthrough = true;
      };

      # Dwindle layout - force horizontal split
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;  # Force horizontal split (2 = right side for new windows)
        smart_split = false;
        smart_resizing = true;
        default_split_ratio = 1.2;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
      };

      # Master layout - horizontal arrangement
      master = {
        new_status = "master";
        orientation = "left";  # Master window on the left
        inherit_fullscreen = true;
        mfact = 0.55;  # 55% for master window
        new_on_top = false;
      };

      # Environment variables
      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "GDK_SCALE,1"  # Force GTK scale to 1
        "QT_SCALE_FACTOR,1"  # Force Qt scale to 1
        "GDK_DPI_SCALE,1"  # Force GTK DPI scale to 1
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];

      # Workspace configuration
      workspace = [
        "1, monitor:, default:true"
        "2, monitor:"
        "3, monitor:"
        "4, monitor:"
        "5, monitor:"
        "6, monitor:"
        "7, monitor:"
        "8, monitor:"
        "9, monitor:"
        "10, monitor:"
      ];

      # Workspace behavior
      misc = {
        disable_autoreload = false;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = false;
        focus_on_activate = false;
        new_window_takes_over_fullscreen = 0;
        background_color = "rgb(15, 25, 35)";
      };
    };

    # Enhanced configuration for horizontal workspace behavior
    extraConfig = ''
      # Force horizontal window placement behavior
      bind = $mod, J, layoutmsg, togglesplit
      bind = $mod, H, layoutmsg, preselect l
      bind = $mod, L, layoutmsg, preselect r
    '';
  };
}