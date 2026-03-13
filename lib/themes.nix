# Theme system for NixOS configuration
# This provides a centralized way to access theme colors and settings
{ lib }:

let
  # Import available themes
  cyberpunk = import ../modules/home/themes/cyberpunk/colors.nix;
  rat = import ../modules/home/themes/rat/colors.nix;
  
  # Theme selector function
  getTheme = themeName: {
    cyberpunk = cyberpunk;
    rat = rat;
  }.${themeName} or (throw "Unknown theme: ${themeName}");

in {
  inherit getTheme;
  
  # Default theme
  default = rat;
  
  # Available themes list
  available = [ "cyberpunk" "rat" ];
  
  # Helper functions
  mkThemeOption = lib.mkOption {
    type = lib.types.enum [ "cyberpunk" "rat" ];
    default = "rat";
    description = "Theme to use for the desktop environment";
  };
}