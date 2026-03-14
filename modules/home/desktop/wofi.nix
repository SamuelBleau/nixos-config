{ config, pkgs, lib, ... }:

let
  ratWofiRun = pkgs.writeShellScriptBin "rat-wofi" ''
    #!/usr/bin/env bash
    
    # Kill any existing wofi instance first
    pkill -x wofi 2>/dev/null
    sleep 0.1
    
    # Rat theme menu with effects
    # Display ASCII art in terminal (if run from terminal) or as notification
    if [ -t 1 ]; then
      # Terminal output
      echo -e "\033[1;35m"
      echo "   ____ "
      echo "  / . .\\"
      echo "  \  ---<"
      echo "   \  / "
      echo " ___\/___"
      echo -e "\033[0m"
      echo -e "\033[1;30mENTERING THE SEWERS...\033[0m"
      sleep 0.3
      echo -e "\033[1;35mRAT INSTINCTS ACTIVATED 🐀\033[0m"
      sleep 0.2
      echo -e "\033[1;30mSNIFFING AROUND...\033[0m"
      sleep 0.4
      echo -e "\033[1;35mREADY TO SQUEAK ✓\033[0m"
      sleep 0.2
    else
      # Notification for GUI launch
      notify-send "THE SEWERS" "RAT INSTINCTS ACTIVATED 🐀" --icon=dialog-information
    fi
    
    wofi --show drun \
         --prompt "🐀 THE SEWERS:" \
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
in
{
  home.packages = [ ratWofiRun ];

  programs.wofi = {
    enable = true;
    
    settings = {
      width = 700;
      height = 500;
      location = "center";
      show = "drun";
      prompt = "🐀 THE SEWERS:";
      use_search_box = false;
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
    
    # Rat theme styling
    style = ./wofi-rat.css;
  };

  # Optional: You can create custom aliases for a more rat feel
  home.file.".local/share/applications/neural-interface.desktop" = {
    text = ''
      [Desktop Entry]
      Name=Rat Hole
      Comment=Enter the sewers
      Exec=kitty --hold sh -c "rat-wofi"
      Icon=terminal
      Type=Application
      Categories=System;TerminalEmulator;
      Keywords=rat;sewers;terminal;console;
      StartupNotify=true
    '';
  };
}
