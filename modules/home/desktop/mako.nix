{ config, pkgs, lib, theme, ... }:

{
  services.mako = {
    enable = true;
    
    settings = {
      # Positioning and layout
      anchor = "top-right";
      layer = "overlay";
      margin = "16,16,0,0";
      padding = "12,16";
      width = 350;
      height = 150;
      
      # Appearance
      background-color = theme.ui.background + "E6"; # 90% opacity
      text-color = theme.text.primary;
      border-color = theme.primary.purple;
      border-size = 2;
      border-radius = 8;
      
      # Progress bar (for volume, brightness, etc.)
      progress-color = theme.primary.purpleDark;
      
      # Typography
      font = "JetBrains Mono 11";
      markup = true;
      format = "<b>%s</b>\\n%b";
      
      # Behavior
      default-timeout = 5000;
      ignore-timeout = false;
      max-visible = 5;
      sort = "-time";
      
      # Icons
      icon-path = "/usr/share/icons/Adwaita:/usr/share/pixmaps";
      max-icon-size = 32;
      
      # Grouping
      group-by = "app-name";
      
      # Actions
      actions = true;
      
      # History
      max-history = 100;
    };
    
    # Special notification categories with cyberpunk styling
    extraConfig = ''
      [urgency=low]
      border-color=${theme.secondary.blue}
      background-color=${theme.ui.surface}CC
      text-color=${theme.text.secondary}
      default-timeout=3000
      
      [urgency=normal]
      border-color=${theme.primary.purple}
      background-color=${theme.ui.background}E6
      text-color=${theme.text.primary}
      default-timeout=5000
      
      [urgency=critical]
      border-color=${theme.status.error}
      background-color=${theme.status.error}33
      text-color=${theme.text.primary}
      default-timeout=0
      on-notify=exec paplay ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/dialog-error.oga
      
      [app-name="Volume"]
      border-color=${theme.primary.purpleDark}
      background-color=${theme.ui.surface}E6
      format=%b
      default-timeout=2000
      group-by=app-name
      
      [app-name="Brightness"]
      border-color=${theme.primary.gray}
      background-color=${theme.ui.surface}E6
      format=%b
      default-timeout=2000
      group-by=app-name
      
      [app-name="Battery"]
      border-color=${theme.status.warning}
      background-color=${theme.ui.surface}E6
      format=⚡ %s\\n%b
      default-timeout=8000
      
      [app-name="Network"]
      border-color=${theme.secondary.green}
      background-color=${theme.ui.surface}E6
      format=🌐 %s\\n%b
      default-timeout=4000
      
      [app-name="System"]
      border-color=${theme.primary.purple}
      background-color=${theme.ui.background}F0
      format=⚙️ %s\\n%b
      default-timeout=6000
      
      [app-name="Security"]
      border-color=${theme.status.error}
      background-color=${theme.status.error}20
      format=🔒 %s\\n%b
      default-timeout=10000
      
      [summary~=".*[Cc]yberpunk.*"]
      border-color=${theme.primary.purpleDark}
      background-color=${theme.primary.purpleDark}20
      text-color=${theme.primary.purple}
      format=🤖 %s\\n%b
      default-timeout=7000
      
      [summary~=".*[Ee]rror.*"]
      border-color=${theme.status.error}
      background-color=${theme.status.error}30
      text-color=${theme.text.primary}
      default-timeout=8000
      
      [summary~=".*[Ss]uccess.*"]
      border-color=${theme.status.success}
      background-color=${theme.status.success}30
      text-color=${theme.text.primary}
      default-timeout=4000
      
      [summary~=".*[Ww]arning.*"]
      border-color=${theme.status.warning}
      background-color=${theme.status.warning}30
      text-color=${theme.ui.background}
      default-timeout=6000
    '';
  };

  # Custom notification scripts for cyberpunk system events
  home.file.".config/mako/scripts/cyberpunk-notify.sh" = {
    text = ''
      #!/usr/bin/env bash
      
      # Cyberpunk-themed notification sender
      
      send_cyber_notification() {
          local title="$1"
          local message="$2"
          local urgency="$3"
          local app_name="$4"
          local icon="$5"
          
          notify-send \
              --app-name="''${app_name:-System}" \
              --urgency="''${urgency:-normal}" \
              --icon="''${icon:-dialog-information}" \
              --expire-time=5000 \
              "🔥 $title" \
              "$message"
      }
      
      # Predefined cyberpunk notifications
      case "$1" in
          "startup")
              send_cyber_notification "NEURAL LINK ESTABLISHED" "Cyberpunk desktop environment loaded successfully" "normal" "Cyberpunk" "computer"
              ;;
          "quickhacks")
              send_cyber_notification "QUICKHACKS ACTIVATED" "Neural interface menu accessed" "normal" "Cyberpunk" "applications-system"
              ;;
          "volume")
              send_cyber_notification "AUDIO LEVELS" "Volume: $2%" "low" "Volume" "audio-volume-high"
              ;;
          "brightness")
              send_cyber_notification "OPTICAL ENHANCEMENT" "Brightness: $2%" "low" "Brightness" "display-brightness"
              ;;
          "wifi-connected")
              send_cyber_notification "NET ACCESS GRANTED" "Connected to neural network: $2" "normal" "Network" "network-wireless"
              ;;
          "wifi-disconnected")
              send_cyber_notification "NET ACCESS LOST" "Disconnected from neural network" "normal" "Network" "network-wireless-disconnected"
              ;;
          "battery-low")
              send_cyber_notification "POWER CRITICAL" "Neural implant battery at $2%" "critical" "Battery" "battery-caution"
              ;;
          "battery-charging")
              send_cyber_notification "POWER RESTORATION" "Neural implant charging: $2%" "normal" "Battery" "battery-charging"
              ;;
          "lock")
              send_cyber_notification "NEURAL LOCK ENGAGED" "System secured with biometric protocols" "normal" "Security" "system-lock-screen"
              ;;
          "unlock")
              send_cyber_notification "BIOMETRIC VERIFIED" "Neural access granted" "normal" "Security" "system-lock-screen"
              ;;
          "error")
              send_cyber_notification "SYSTEM ANOMALY" "$2" "critical" "System" "dialog-error"
              ;;
          "success")
              send_cyber_notification "OPERATION COMPLETE" "$2" "normal" "System" "dialog-information"
              ;;
          *)
              send_cyber_notification "CUSTOM MESSAGE" "$2" "normal" "Cyberpunk" "dialog-information"
              ;;
      esac
    '';
    executable = true;
  };

  # Service to send startup notification
  systemd.user.services.cyberpunk-startup-notification = {
    Unit = {
      Description = "Cyberpunk startup notification";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    
    Service = {
      Type = "oneshot";
      ExecStart = "${config.home.homeDirectory}/.config/mako/scripts/cyberpunk-notify.sh startup";
      RemainAfterExit = false;
    };
    
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}