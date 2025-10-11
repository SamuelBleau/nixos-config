{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = false; # Désactivé pour éviter conflit
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 4;
        
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "custom/music" "network" "bluetooth" "pulseaudio" "battery" "custom/power" ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "●";
            "2" = "●";
            "3" = "●";
            "4" = "●";
            "5" = "●";
            "6" = "●";
            "7" = "●";
            "8" = "●";
            "9" = "●";
            "10" = "●";
            urgent = "●";
            focused = "●";
            default = "●";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%A %d %B %Y - %H:%M}";
          format-alt = "{:%d/%m/%Y %H:%M:%S}";
        };

        cpu = {
          format = "{usage}% ";
          tooltip = false;
          interval = 1;
        };

        memory = {
          format = "{}% ";
          interval = 1;
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
          interval = 30;
        };

        network = {
          format-wifi = "󰤨 {essid}";
          format-ethernet = "󰈀";
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          format-linked = "󰤭 {ifname} (No IP)";
          format-disconnected = "󰤮 Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          interval = 5;
        };

        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-off = "󰂲";
          format-on = "󰂯";
          format-connected = "󰂱 {device_alias}";
          format-connected-battery = "󰂱 {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "blueman-manager";
        };

        pulseaudio = {
          format = "󰕾 {volume}%";
          format-bluetooth = "󰕾 {volume}%";
          format-bluetooth-muted = "󰖁";
          format-muted = "󰖁";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰏳";
            headset = "󰋎";
            phone = "󰏲";
            portable = "󰦧";
            car = "󰄋";
            default = ["󰖀" "󰕾" "󰕾"];
          };
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        "custom/music" = {
          format = "󰎆 {}";
          max-length = 50;
          interval = 2;
          exec = "playerctl metadata --format '{{ artist }} - {{ title }}' 2>/dev/null || echo 'Aucune musique'";
          tooltip-format = "󰎆 {}\nArtiste: {{ artist }}\nAlbum: {{ album }}\nTitre: {{ title }}";
          exec-tooltip = "playerctl metadata --format 'Artiste: {{ artist }}\nAlbum: {{ album }}\nTitre: {{ title }}' 2>/dev/null || echo 'Aucune information disponible'";
          on-click = "hyprctl dispatch focuswindow class:deezer-enhanced || deezer-enhanced";
          on-click-right = "playerctl play-pause";
          on-scroll-up = "playerctl next";
          on-scroll-down = "playerctl previous";
        };

        "custom/power" = {
          format = "󰐥";
          tooltip = false;
          on-click = "wlogout";
          on-click-right = "systemctl poweroff";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: 'JetBrains Mono', 'Font Awesome 6 Free', monospace;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(26, 22, 37, 0.85);
        color: #e4e4e7;
        transition-property: background-color;
        transition-duration: .5s;
        border-bottom: 3px solid rgba(139, 92, 246, 0.6);
      }

      button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: 0;
      }

      #workspaces button {
        padding: 0 8px;
        background-color: transparent;
        color: #ffffff;
        border-bottom: 3px solid transparent;
        font-size: 16px;
      }

      #workspaces button:hover {
        background: rgba(139, 92, 246, 0.2);
        color: #a855f7;
      }

      #workspaces button.active {
        background-color: transparent;
        color: #a855f7;
        border-bottom: 3px solid #a855f7;
      }

      #workspaces button.urgent {
        background-color: #f87171;
        color: #1a1625;
      }

      #mode {
        background-color: #7c3aed;
        border-bottom: 3px solid #c084fc;
      }

      #clock,
      #battery,
      #network,
      #pulseaudio,
      #bluetooth,
      #custom-music,
      #custom-power {
        padding: 0 10px;
        color: #e4e4e7;
      }

      #workspaces {
        margin: 0 4px;
      }

      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }

      .modules-right > widget:last-child > #custom-power {
        margin-right: 0;
      }

      #clock {
        background-color: rgba(168, 85, 247, 0.3);
        border-bottom: 3px solid #a855f7;
      }

      #battery {
        background-color: rgba(34, 197, 94, 0.3);
        border-bottom: 3px solid #22c55e;
      }

      #battery.charging,
      #battery.plugged {
        background-color: rgba(251, 191, 36, 0.3);
        border-bottom: 3px solid #fbbf24;
      }

      @keyframes blink {
        to {
          background-color: #f38ba8;
          color: #11111b;
        }
      }

      #battery.critical:not(.charging) {
        background-color: #f38ba8;
        color: #11111b;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #network {
        background-color: rgba(124, 58, 237, 0.3);
        border-bottom: 3px solid #7c3aed;
      }

      #network.disconnected {
        background-color: #f87171;
        color: #1a1625;
      }

      #bluetooth {
        background-color: rgba(59, 130, 246, 0.3);
        border-bottom: 3px solid #3b82f6;
      }

      #bluetooth.disabled {
        background-color: rgba(76, 29, 149, 0.3);
        color: #9ca3af;
      }

      #pulseaudio {
        background-color: rgba(139, 92, 246, 0.3);
        border-bottom: 3px solid #8b5cf6;
      }

      #pulseaudio.muted {
        background-color: rgba(76, 29, 149, 0.3);
        color: #9ca3af;
      }

      #custom-music {
        background: linear-gradient(45deg, rgba(0, 245, 255, 0.2), rgba(255, 0, 128, 0.2));
        border-bottom: 3px solid #00f5ff;
        color: #00f5ff;
        font-weight: bold;
        transition: all 0.3s ease;
        text-shadow: 0 0 6px #00f5ff;
        animation: pulse-music 2s ease-in-out infinite alternate;
      }

      #custom-music:hover {
        background: linear-gradient(45deg, rgba(0, 245, 255, 0.4), rgba(255, 0, 128, 0.4));
        box-shadow: 0 0 15px rgba(0, 245, 255, 0.6);
        text-shadow: 0 0 10px #00f5ff;
      }

      @keyframes pulse-music {
        from { box-shadow: 0 0 8px rgba(0, 245, 255, 0.3); }
        to { box-shadow: 0 0 12px rgba(0, 245, 255, 0.6); }
      }

      #custom-power {
        background-color: rgba(239, 68, 68, 0.3);
        border-bottom: 3px solid #ef4444;
      }

      #custom-power:hover {
        background-color: rgba(239, 68, 68, 0.5);
      }
    '';
  };
}
