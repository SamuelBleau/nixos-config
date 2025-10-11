{ config, pkgs, lib, ... }:

{
  # Cyberpunk sound effects for desktop
  home.file = {
    # Sound directory structure
    ".config/cyberpunk/sounds/.keep".text = "";
    
    # Sound configuration file for cyberpunk theme
    ".config/cyberpunk/sounds.conf".text = ''
      # Cyberpunk sound configuration
      [system]
      login_sound=/etc/nixos/assets/sounds/cyberpunk-login.wav
      logout_sound=/etc/nixos/assets/sounds/cyberpunk-logout.wav
      notification_sound=/etc/nixos/assets/sounds/cyberpunk-notification.wav
      
      [ui]
      hover_sound=/etc/nixos/assets/sounds/cyberpunk-hover.wav
      click_sound=/etc/nixos/assets/sounds/cyberpunk-click.wav
      error_sound=/etc/nixos/assets/sounds/cyberpunk-error.wav
      
      [effects]
      quickhack_open=/etc/nixos/assets/sounds/quickhack-open.wav
      terminal_startup=/etc/nixos/assets/sounds/terminal-startup.wav
      
      [volume]
      system_volume=0.3
      ui_volume=0.2
      notification_volume=0.5
    '';
  };
  
  # Ensure PulseAudio/Pipewire integration for sound effects
  home.packages = with pkgs; [
    pavucontrol
    paprefs
    playerctl
  ];
}