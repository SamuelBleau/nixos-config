{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      # Aliases de base
      ll = "ls -lah";
      la = "ls -la";
      l = "ls -l";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#meeast-laptop";
      cwofi = "rat-wofi";
      
      # Aliases Rat décoratifs
      "rat-help" = "echo -e 'RAT TERMINAL COMMANDS:\\n• wallpaper-cycle - Change wallpaper\\n• matrix - Enter the Sewers\\n• neofetch - System info display\\n• rat-status - System status\\n• rat-art - Show Rat ASCII art'";
      "rat-art" = "~/.config/kitty/rat-startup.sh";
      
      # Scripts utiles
      "wallpaper-cycle" = "/etc/nixos/assets/scripts/rat-wallpaper.sh";
      "rat-wall" = "/etc/nixos/assets/scripts/rat-wallpaper.sh";
      
      # Commandes système avec style
      "rat-status" = "echo 'SEWER STATUS' && echo '' && uptime && echo '' && df -h / && echo '' && free -h";
      "sewer-gate" = "sudo systemctl status firewalld";
      "rat-link" = "ping -c 4 8.8.8.8";
      
      # Surveillance système
      "processes" = "htop";
      "network" = "ss -tuln";
      "logs" = "journalctl -f";
      
      # Commandes développement
      "rebuild" = "sudo nixos-rebuild switch --flake /etc/nixos#meeast-laptop";
      "reboot-safe" = "systemctl reboot";
      "shutdown-safe" = "systemctl poweroff";
      
      # Fun Rat
      "matrix" = "cmatrix -C magenta";
      "swarm" = "echo 'RAT SWARM ACTIVATED' && sleep 1 && cmatrix -C magenta";
      "glitch" = "echo 'SEWER COLLAPSE DETECTED' && for i in {1..5}; do echo -n '▓▓▓'; sleep 0.1; done; echo ''";
      
      # Raccourcis navigation
      "home-config" = "cd /etc/nixos && ls -la";
      "rat-assets" = "cd /etc/nixos/assets && ls -la";
      "themes" = "cd /etc/nixos/modules/home/themes && ls -la";
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
    
    initContent = ''
      # Rat terminal setup - only show when not already displayed
      if [[ $- == *i* ]] && [[ -z "$RAT_SHOWN" ]] && [[ -z "$KITTY_WINDOW_ID" ]]; then
        export RAT_SHOWN=1
        if [[ -f ~/.config/kitty/rat-startup.sh ]]; then
          ~/.config/kitty/rat-startup.sh
        fi
      fi
      
      # Git branch helper
      git_branch() {
        # prefer git symbolic-ref, fallback to git rev-parse
        local branch
        if branch=$(git symbolic-ref --short HEAD 2>/dev/null); then
          printf " (%s)" "$branch"
          return 0
        fi
        if branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); then
          if [[ "$branch" != "HEAD" ]]; then
            printf " (%s)" "$branch"
            return 0
          fi
        fi
        return 0
      }

      setopt PROMPT_SUBST

      if [[ -n "$KITTY_WINDOW_ID" ]]; then
        # Modified prompt for Rat terminal
        PS1="%{$fg[magenta]%}[%{$fg[white]%}%n%{$fg[magenta]%}@%{$fg[black]%}%m%{$fg[magenta]%}]%{$reset_color%} %{$fg[magenta]%}%~%{$reset_color%}"
        PS1+="%{$fg[blue]%}
$(git_branch 2>/dev/null)%{$reset_color%} %{$fg[magenta]%}🐀%{$reset_color%} "
      fi
    '';
  };
}
