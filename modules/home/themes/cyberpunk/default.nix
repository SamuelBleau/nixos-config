{ config, pkgs, lib, ... }:

with lib;
let
  colors = import ./colors.nix;
in
{
  imports = [
    ./wallpapers.nix
    ./fonts.nix
    ./sounds.nix
  ];

  config = mkIf (config.meeast.desktop.theme == "cyberpunk") {
    # Cyberpunk theme configuration files
    home.file = {
      # Main theme configuration
      ".config/cyberpunk/theme.conf".text = ''
        # Cyberpunk 2077 theme configuration
        [theme]
        name=cyberpunk-2077
        variant=night-city
        version=1.0
        
        [colors]
        primary_cyan=${colors.primary.cyan}
        primary_magenta=${colors.primary.magenta}
        primary_yellow=${colors.primary.yellow}
        
        [effects]
        enable_glow=true
        enable_blur=true
        enable_transparency=true
        animation_speed=fast
      '';
      
      # Export colors for scripts
      ".config/cyberpunk/colors.sh" = {
        text = ''
          #!/usr/bin/env bash
          # Cyberpunk color variables for shell scripts
          
          # Primary colors
          export CYBER_CYAN="${colors.primary.cyan}"
          export CYBER_MAGENTA="${colors.primary.magenta}"
          export CYBER_YELLOW="${colors.primary.yellow}"
          
          # UI colors
          export CYBER_BG="${colors.ui.background}"
          export CYBER_SURFACE="${colors.ui.surface}"
          export CYBER_TEXT="${colors.text.primary}"
          
          # Status colors
          export CYBER_SUCCESS="${colors.status.success}"
          export CYBER_WARNING="${colors.status.warning}"
          export CYBER_ERROR="${colors.status.error}"
        '';
        executable = true;
      };
    };

    # Export colors as session variables
    home.sessionVariables = {
      CYBERPUNK_PRIMARY_CYAN = colors.primary.cyan;
      CYBERPUNK_PRIMARY_MAGENTA = colors.primary.magenta;
      CYBERPUNK_PRIMARY_YELLOW = colors.primary.yellow;
      CYBERPUNK_UI_BACKGROUND = colors.ui.background;
      CYBERPUNK_TEXT_PRIMARY = colors.text.primary;
    };
  };
}
