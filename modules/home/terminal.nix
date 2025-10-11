# Terminal configuration module
{ config, lib, pkgs, theme, ... }:

with lib;

{
  imports = [
    ./terminal/kitty.nix
    ./terminal/zsh.nix
  ];
}