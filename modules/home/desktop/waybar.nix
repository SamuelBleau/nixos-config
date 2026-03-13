{ config, pkgs, lib, theme, ... }:

with lib;

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    
    settings = {
      mainBar = {
        layer = "top";
        position = config.meeast.desktop.waybar.position;
        height = config.meeast.desktop.waybar.height;
        spacing = 4;
        margin-top = 8;
        margin-bottom = 0;
        margin-left = 16;
        margin-right = 16;
        
        modules-left = [ "hyprland/workspaces" "hyprland/mode" "hyprland/scratchpad" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "temperature" "battery" "clock" "tray" ];
        
        # Hyprland workspaces - cyberpunk style
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            "1" = "󰍩"; # Terminal
            "2" = "󰈹"; # Browser  
            "3" = "󰨞"; # Code
            "4" = "󰉋"; # Files
            "5" = "󰎄"; # Media
            "6" = "󰙯"; # Communication
            "7" = "󰖟"; # Documents
            "8" = "󰊗"; # Games
            "9" = "󰘳"; # Social
            "10" = "󰝚"; # Music
            urgent = "󰀧";
            default = "󰇘";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };
        
        "hyprland/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        
        "hyprland/scratchpad" = {
          format = "{icon} {count}";
          show-empty = false;
          format-icons = [ "" "󰖯" ];
          tooltip = true;
          tooltip-format = "{app}: {title}";
        };
        
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
          separate-outputs = true;
          rewrite = {
            "(.*) — Mozilla Firefox" = "󰈹 $1";
            "(.*) - Visual Studio Code" = "󰨞 $1";
            "(.*) - Kitty" = "󰍩 $1";
            "(.*) - Files" = "󰉋 $1";
          };
        };
        
        # System modules with cyberpunk aesthetics
        tray = {
          icon-size = 18;
          spacing = 8;
        };
        
        clock = {
          format = "󰥔 {:%H:%M}";
          format-alt = "󰸗 {:%Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          actions = {
            on-click-right = "mode";
          };
        };
        
        cpu = {
          format = "󰍛 {usage}%";
          tooltip = false;
          interval = 2;
        };
        
        memory = {
          format = "󰘚 {percentage}%";
          tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G\nSwap: {swapUsed:0.1f}G / {swapTotal:0.1f}G";
          interval = 2;
        };
        
        temperature = {
          thermal-zone = 2;
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          format-critical = "󰸁 {temperatureC}°C";
          format = "󰔏 {temperatureC}°C";
          interval = 2;
        };
        
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄 {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip-format = "{timeTo}, {capacity}%";
        };
        
        network = {
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰈀 Connected";
          tooltip-format = "{ifname} via {gwaddr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "󰤭 Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          on-click-right = "nm-connection-editor";
        };
        
        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon}󰂯 {volume}%";
          format-bluetooth-muted = "󰸩󰂯";
          format-muted = "󰸩";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰥰";
            headset = "󰋎";
            phone = "󰄜";
            portable = "󰦧";
            car = "󰄋";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
      };
    };
    
    style = ''
      * {
        font-family: "JetBrains Mono", "Font Awesome 6 Free";
        font-size: 13px;
        border: none;
        border-radius: 0;
        min-height: 0;
      }
      
      window#waybar {
        background: ${theme.ui.background}d9; /* 85% opacity */
        border: 2px solid ${theme.primary.purple}cc; /* 80% opacity */
        border-radius: 12px;
        color: ${theme.text.primary};
        transition-property: background-color;
        transition-duration: 0.5s;
      }
      
      window#waybar.hidden {
        opacity: 0.2;
      }
      
      /* Workspaces */
      #workspaces {
        background: ${theme.ui.surface}99;
        border-radius: 8px;
        margin: 4px;
        padding: 0 8px;
      }
      
      #workspaces button {
        padding: 0 6px;
        background-color: transparent;
        color: ${theme.text.secondary};
        border-radius: 6px;
        transition: all 0.3s ease;
      }
      
      #workspaces button:hover {
        background: ${theme.primary.purple}4d;
        color: ${theme.text.primary};
        text-shadow: 0 0 8px ${theme.primary.purple};
      }
      
      #workspaces button.active {
        background: linear-gradient(45deg, ${theme.primary.purple}, ${theme.primary.purpleDark});
        color: ${theme.ui.background};
        font-weight: bold;
        box-shadow: 0 0 12px ${theme.primary.purple}99;
      }
      
      #workspaces button.urgent {
        background-color: ${theme.status.error};
        color: ${theme.ui.background};
        animation: blink 1s ease-in-out infinite alternate;
      }
      
      @keyframes blink {
        to {
          background-color: ${theme.status.warning};
          color: ${theme.ui.background};
        }
      }
      
      /* Window title */
      #window {
        background: ${theme.ui.surface}66;
        border-radius: 8px;
        padding: 4px 12px;
        margin: 4px;
        color: ${theme.text.primary};
        font-weight: 500;
      }
      
      /* System modules */
      #clock,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #network,
      #pulseaudio,
      #tray {
        background: rgba(${builtins.substring 1 6 theme.ui.surface}, 0.6);
        border-radius: 8px;
        padding: 4px 10px;
        margin: 4px 2px;
        color: ${theme.text.primary};
        transition: all 0.3s ease;
      }
      
      #clock:hover,
      #battery:hover,
      #cpu:hover,
      #memory:hover,
      #temperature:hover,
      #network:hover,
      #pulseaudio:hover {
        background: rgba(${builtins.substring 1 6 theme.primary.purple}, 0.3);
        text-shadow: 0 0 6px ${theme.primary.purple};
        transform: translateY(-1px);
      }
      
      /* Status-specific styling */
      #battery.charging {
        background: linear-gradient(45deg, ${theme.status.success}, ${theme.primary.purple});
        color: ${theme.ui.background};
      }
      
      #battery.warning:not(.charging) {
        background: ${theme.status.warning};
        color: ${theme.ui.background};
        animation: pulse 2s ease-in-out infinite;
      }
      
      #battery.critical:not(.charging) {
        background: ${theme.status.error};
        color: ${theme.ui.background};
        animation: pulse 1s ease-in-out infinite;
      }
      
      @keyframes pulse {
        to {
          box-shadow: 0 0 20px rgba(${builtins.substring 1 6 theme.status.error}, 0.8);
        }
      }
      
      #temperature.critical {
        background: ${theme.status.error};
        color: ${theme.ui.background};
        animation: pulse 2s ease-in-out infinite;
      }
      
      #network.disconnected {
        background: rgba(${builtins.substring 1 6 theme.status.error}, 0.8);
        color: ${theme.text.primary};
      }
      
      #pulseaudio.muted {
        background: rgba(${builtins.substring 1 6 theme.text.disabled}, 0.6);
        color: ${theme.text.disabled};
      }
      
      /* Tray */
      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: ${theme.status.warning};
        border-radius: 6px;
      }
      
      /* Mode indicator */
      #mode {
        background: linear-gradient(45deg, ${theme.primary.purpleDark}, ${theme.primary.gray});
        color: ${theme.ui.background};
        border-radius: 8px;
        padding: 4px 10px;
        margin: 4px;
        font-weight: bold;
        animation: glow 2s ease-in-out infinite alternate;
      }
      
      @keyframes glow {
        to {
          box-shadow: 0 0 15px rgba(${builtins.substring 1 6 theme.primary.purpleDark}, 0.8);
        }
      }
      
      /* Scratchpad */
      #scratchpad {
        background: rgba(${builtins.substring 1 6 theme.primary.gray}, 0.8);
        color: ${theme.ui.background};
        border-radius: 8px;
        padding: 4px 10px;
        margin: 4px;
      }
    '';
  };
}