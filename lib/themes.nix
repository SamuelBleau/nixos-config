# Theme system for NixOS configuration
# This provides a centralized way to access theme colors and settings
{ lib }:

let
  # Import available themes
  cyberpunk = import ../modules/home/themes/cyberpunk/colors.nix;
  
  # Theme selector function
  getTheme = themeName: {
    cyberpunk = cyberpunk;
  }.${themeName} or (throw "Unknown theme: ${themeName}");

in {
  inherit getTheme;
  
  # Default theme
  default = cyberpunk;
  
  # Available themes list
  available = [ "cyberpunk" ];
  
  # Helper functions
  mkThemeOption = lib.mkOption {
    type = lib.types.enum [ "cyberpunk" ];
    default = "cyberpunk";
    description = "Theme to use for the desktop environment";
  };
}