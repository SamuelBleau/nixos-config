# Central options module for home configuration
{ config, lib, pkgs, ... }:

with lib;

{
  options.meeast = {
    desktop = {
      enable = mkEnableOption "desktop environment";
      
      theme = mkOption {
        type = types.enum [ "cyberpunk" ];
        default = "cyberpunk";
        description = "Theme to use for the desktop environment";
      };
      
      hyprland = {
        enable = mkEnableOption "Hyprland window manager";
        
        animations = {
          enable = mkOption {
            type = types.bool;
            default = true;
            description = "Enable window animations";
          };
        };
        
        gaps = {
          inner = mkOption {
            type = types.int;
            default = 8;
            description = "Inner gap size in pixels";
          };
          
          outer = mkOption {
            type = types.int;
            default = 24;
            description = "Outer gap size in pixels";
          };
        };
        
        borderSize = mkOption {
          type = types.int;
          default = 2;
          description = "Window border size in pixels";
        };
      };
      
      waybar = {
        enable = mkEnableOption "Waybar status bar";
        
        position = mkOption {
          type = types.enum [ "top" "bottom" ];
          default = "top";
          description = "Position of the waybar";
        };
        
        height = mkOption {
          type = types.int;
          default = 36;
          description = "Height of the waybar in pixels";
        };
      };
    };
    
    terminal = {
      default = mkOption {
        type = types.enum [ "kitty" "alacritty" ];
        default = "kitty";
        description = "Default terminal emulator";
      };
      
      opacity = mkOption {
        type = types.float;
        default = 0.9;
        description = "Terminal opacity (0.0 to 1.0)";
      };
    };
    
    development = {
      enable = mkEnableOption "development tools";
      
      vscode = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable VS Code";
        };
      };
      
      git = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable Git configuration";
        };
      };
    };
  };
}