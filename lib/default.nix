# Default lib functions for the configuration
{ lib, ... }:

{
  # Import our custom library functions
  themes = import ./themes.nix { inherit lib; };
  
  # Helper function to create default options
  mkDefaultOption = type: default: description: lib.mkOption {
    inherit type default description;
  };
  
  # Helper to create enable options
  mkEnableOption = description: lib.mkEnableOption description;
}