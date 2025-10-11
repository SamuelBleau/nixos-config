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
      cwofi = "~/.config/wofi/quickhacks.sh";
      
      # Aliases cyberpunk décoratifs
      "cyber-help" = "echo -e 'CYBERPUNK TERMINAL COMMANDS:\\n• wallpaper-cycle - Change cyberpunk wallpaper\\n• matrix - Enter the Matrix\\n• neofetch - System info display\\n• cyber-status - System status\\n• cyber-art - Show cyberpunk ASCII art'";
      "cyber-art" = "~/.config/kitty/cyberpunk-startup.sh";
      
      # Scripts utiles
      "wallpaper-cycle" = "/etc/nixos/assets/scripts/cyberpunk-wallpaper.sh";
      "cyber-wall" = "/etc/nixos/assets/scripts/cyberpunk-wallpaper.sh";
      
      # Commandes système avec style
      "cyber-status" = "echo 'SYSTEM STATUS' && echo '' && uptime && echo '' && df -h / && echo '' && free -h";
      "ice-wall" = "sudo systemctl status firewalld";
      "neural-link" = "ping -c 4 8.8.8.8";
      
      # Surveillance système
      "processes" = "htop";
      "network" = "ss -tuln";
      "logs" = "journalctl -f";
      
      # Commandes développement
      "rebuild" = "sudo nixos-rebuild switch --flake /etc/nixos#meeast-laptop";
      "reboot-safe" = "systemctl reboot";
      "shutdown-safe" = "systemctl poweroff";
      
      # Fun cyberpunk
      "matrix" = "cmatrix -C cyan";
      "hack-mode" = "echo 'HACKING MODE ACTIVATED' && sleep 1 && cmatrix -C magenta";
      "glitch" = "echo 'SYSTEM GLITCH DETECTED' && for i in {1..5}; do echo -n '▓▓▓'; sleep 0.1; done; echo ''";
      
      # Raccourcis navigation
      "home-config" = "cd /etc/nixos && ls -la";
      "cyber-assets" = "cd /etc/nixos/assets && ls -la";
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
      # Cyberpunk terminal setup - only show when not already displayed
      # This prevents duplicate displays when using Kitty startup sessions
      if [[ $- == *i* ]] && [[ -z "$CYBERPUNK_SHOWN" ]] && [[ -z "$KITTY_WINDOW_ID" ]]; then
        export CYBERPUNK_SHOWN=1
        if [[ -f ~/.config/kitty/cyberpunk-startup.sh ]]; then
          ~/.config/kitty/cyberpunk-startup.sh
        fi
      fi
      
      # Custom cyberpunk prompt enhancement
      # Git branch helper: prints either empty or ' (branch-name)'
      git_branch() {
        # prefer git symbolic-ref, fallback to git rev-parse
        local branch
        if branch=$(git symbolic-ref --short HEAD 2>/dev/null); then
          printf " (%s)" "$branch"
          return 0
        fi
        if branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); then
          # ignore detached HEAD or non-branch output
          if [[ "$branch" != "HEAD" ]]; then
            printf " (%s)" "$branch"
            return 0
          fi
        fi
        return 0
      }

      # Ensure command substitution is evaluated inside PS1
      setopt PROMPT_SUBST

      if [[ -n "$KITTY_WINDOW_ID" ]]; then
        # Enhanced prompt for Kitty terminal: show user@host, cwd and git branch
        PS1="%{$fg[cyan]%}[%{$fg[magenta]%}%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$fg[cyan]%}]%{$reset_color%} %{$fg[yellow]%}%~%{$reset_color%}"
        PS1+="%{$fg[blue]%}
$(git_branch 2>/dev/null)%{$reset_color%} %{$fg[cyan]%}⚡%{$reset_color%} "
      fi
    '';
  };
}
