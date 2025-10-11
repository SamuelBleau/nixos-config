{ config, pkgs, lib, ... }:

{
  programs.wofi = {
    enable = true;
    
    settings = {
      width = 700;
      height = 500;
      location = "center";
      show = "drun";
      prompt = "AVAILABLE QUICKHACKS:";
      allow_markup = true;
      no_actions = true;
      insensitive = true;
      allow_images = true;
      gtk_dark = true;
      dynamic_lines = false;
      cache_file = "/dev/null";
      normal_window = true;
      term = "kitty";
      matching = "contains";
      sort_order = "alphabetical";
      columns = 1;
      print_command = true;
    };
    
    # Utiliser le CSS externe cyberpunk
    style = ./wofi-cyberpunk.css;
  };

  # Add custom wofi launcher script for enhanced quickhacks effect
  home.file.".config/wofi/quickhacks.sh" = {
    text = ''
      #!/usr/bin/env bash
      
      # Kill any existing wofi instance first
      pkill wofi 2>/dev/null
      sleep 0.1
      
      # Cyberpunk 2077 style quickhacks menu with enhanced effects
      # Display ASCII art in terminal (if run from terminal) or as notification
      if [ -t 1 ]; then
        # Terminal output
        echo -e "\033[1;36m"
        echo "██████╗  ██████╗ ███████╗███████╗"
        echo "╚════██╗██╔═══██╗╚════██║╚════██║"
        echo " █████╔╝██║   ██║    ██╔╝    ██╔╝"
        echo "██╔═══╝ ██║   ██║   ██╔╝    ██╔╝ "
        echo "███████╗╚██████╔╝   ██║     ██║  "
        echo "╚══════╝ ╚═════╝    ╚═╝     ╚═╝  "
        echo -e "\033[0m"
        echo -e "\033[1;32mINITIALIZING QUICKHACKS INTERFACE...\033[0m"
        sleep 0.3
        echo -e "\033[1;32mNEURAL LINK ESTABLISHED ✓\033[0m"
        sleep 0.2
        echo -e "\033[1;33mSCANNING AVAILABLE PROGRAMS...\033[0m"
        sleep 0.4
        echo -e "\033[1;35mBREACH PROTOCOL READY ✓\033[0m"
        sleep 0.2
      else
        # Notification for GUI launch
        notify-send "CYBERPUNK 2077" "QUICKHACKS INTERFACE ACTIVATED" --icon=dialog-information
      fi
      
      wofi --show drun \
           --prompt "AVAILABLE QUICKHACKS:" \
           --width 700 \
           --height 500 \
           --location center \
           --allow-images \
           --gtk-dark \
           --normal-window \
           --insensitive \
           --matching contains \
           --sort-order alphabetical
    '';
    executable = true;
  };

  # Optional: You can create custom aliases for a more cyberpunk feel
  home.file.".local/share/applications/neural-interface.desktop" = {
    text = ''
      [Desktop Entry]
      Name=Neural Interface
      Comment=Access neural terminal
      Exec=kitty
      Icon=terminal
      Type=Application
      Categories=System;TerminalEmulator;
      Keywords=quickhack;neural;terminal;console;cyberpunk;
      StartupNotify=true
    '';
  };
}