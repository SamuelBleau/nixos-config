{ config, lib, ... }:

with lib;

{
  programs.git = mkIf config.meeast.development.git.enable {
    enable = true;
    userName = "SamuelBleau";
    userEmail = "samuel.bleau@epitech.eu";
    extraConfig = {
      init.defaultBranch = "main";
      color.ui = true;
    };
  };
}
