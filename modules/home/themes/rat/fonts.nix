{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.hack
  ];

  # Using Hack Nerd Font for the Rat theme
  home.sessionVariables = {
    RAT_FONT_MONO = "Hack Nerd Font Mono";
    RAT_FONT_REGULAR = "Hack Nerd Font";
  };
}
