{ config, pkgs, lib, ... }:

with lib;

{
  programs.vscode = mkIf config.meeast.development.vscode.enable {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint
      haskell.haskell
    ];
  };
}
