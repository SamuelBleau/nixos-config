{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Execution at startup
    exec-once = [
      # Core desktop environment
      # "waybar" # Removed - managed by Home Manager in waybar.nix
      "mako"
      "swww-daemon && sleep 2 && swww img /etc/nixos/assets/wallpapers/cyberpunk/cyberpunk-lucy.webp --transition-type grow --transition-pos center --transition-step 255 --transition-duration 1.5"
      
      # System utilities
      "nm-applet --indicator"
      "blueman-applet"
      
      # Cursor setup
      "hyprctl setcursor Adwaita 24"
      
      # Cyberpunk startup notification
      #"sleep 2 && /home/meeast/.config/mako/scripts/cyberpunk-notify.sh startup"
      
      # Auto-lock setup
      "swayidle -w timeout 300 'swaylock --color 1a1625' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock --color 1a1625'"
      
      # Clipboard manager
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      
      # Portal setup for screen sharing
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    ];
  };
}