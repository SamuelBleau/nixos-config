# Desktop environment module with options
{ config, lib, pkgs, theme, ... }:

with lib;

{
  imports = [
    ./options.nix
    ./desktop/hyprland
    ./desktop/waybar.nix
    ./desktop/wofi.nix
    ./desktop/mako.nix
    ./themes/cyberpunk
  ];

  config = mkIf config.meeast.desktop.enable {
    # Desktop packages
    home.packages = with pkgs; [
      # Wayland utilities
      grim slurp wl-clipboard wl-color-picker wlogout
      
      # Desktop environment
      swww wofi mako waybar swaylock-effects
      hyprpicker hyprpaper
      
      # System utilities
      brightnessctl playerctl pamixer pavucontrol
      
      # Network and connectivity
      networkmanager networkmanagerapplet blueman
      
      # File management
      nautilus file-roller
      
      # Media
      mpv imv
      
      # Fonts
      jetbrains-mono font-awesome noto-fonts noto-fonts-emoji
      
      # System monitoring
      htop btop neofetch
      
      # Archive tools
      unzip zip p7zip
      
      # Gaming
      steam lutris
      
      # Fun terminal tools
      cmatrix hollywood figlet lolcat
    ];

    # XDG directories
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = "${config.home.homeDirectory}/Desktop";
        documents = "${config.home.homeDirectory}/Documents";
        download = "${config.home.homeDirectory}/Downloads";
        music = "${config.home.homeDirectory}/Music";
        pictures = "${config.home.homeDirectory}/Pictures";
        videos = "${config.home.homeDirectory}/Videos";
        templates = "${config.home.homeDirectory}/Templates";
        publicShare = "${config.home.homeDirectory}/Public";
      };
    };

    # Session variables
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = config.meeast.terminal.default;
    };
  };
}