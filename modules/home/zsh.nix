{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -lah";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#meeast-laptop";
      cwofi = "nixos ~/.config/wofi/quickhacks.sh";
    };
    
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" ];
    };
    
    logoutExtra = ''
      # Cleanup Hyprland processes on logout
      if [ -f "/home/meeast/.config/hypr/logout-cleanup.sh" ]; then
          /home/meeast/.config/hypr/logout-cleanup.sh >/dev/null 2>&1 &
      fi
    '';
  };
}
