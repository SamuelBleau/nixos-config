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

  config = mkIf (config.meeast.desktop.theme == "rat") {
    home.sessionVariables = {
      RAT_PRIMARY_PURPLE = colors.primary.purple;
      RAT_BG = colors.ui.background;
      RAT_SURFACE = colors.ui.surface;
      RAT_BORDER = colors.ui.border;
      RAT_TEXT = colors.text.primary;
    };

    home.file.".config/rat/theme.conf".text = ''
      [theme]
      name=dark-rat
      variant=sewer-purple
      version=1.0

      [colors]
      accent=''${colors.primary.purple}
      bg=''${colors.ui.background}
    '';
  };
}
