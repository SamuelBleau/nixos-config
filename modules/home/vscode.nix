{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint
      haskell.haskell
    ];
  };
}
