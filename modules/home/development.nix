# Development tools module
{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./apps/vscode.nix
    ./apps/git.nix
  ];

  config = mkIf config.meeast.development.enable {
    home.packages = with pkgs; [
      # Development tools
      firefox git neovim
      
      # Build tools
      gcc gnumake
      
      # Languages and runtimes
      nodejs python3 rustc cargo
    ];
  };
}