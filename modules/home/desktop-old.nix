{ config, lib, pkgs, theme, ... }:

{
  imports = [
    ./desktop/hyprland
    ./desktop/waybar.nix
    ./desktop/wofi.nix
    ./desktop/mako.nix
    ./terminal/kitty.nix
    ./terminal/zsh.nix
    ./apps/vscode.nix
    ./apps/git.nix
    ./themes/cyberpunk
  ];

  # Ensure all desktop packages are available
  home.packages = with pkgs; [
    # Wayland utilities
    grim
    slurp
    wl-clipboard
    wl-color-picker
    wlogout
    
    # Desktop environment
    swww
    wofi
    mako
    waybar
    swaylock-effects
    hyprpicker
    hyprpaper
    
    # System utilities
    brightnessctl
    playerctl
    pamixer
    pavucontrol
    
    # Network and connectivity
    networkmanager
    networkmanagerapplet
    blueman
    
    # File management
    nautilus
    file-roller
    
    # Media
    mpv
    imv
    
    # Fonts for cyberpunk theme
    jetbrains-mono
    font-awesome
    noto-fonts
    noto-fonts-emoji
    
    # Development
    firefox
    git
    
    # System monitoring
    htop
    btop
    neofetch
    
    # Archive tools
    unzip
    zip
    p7zip
    
    # Gaming
    steam
    lutris
    
    # Cyberpunk extras
    cmatrix
    hollywood
    figlet
    lolcat
  ];

  # XDG user directories
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
    
    # MIME type associations for cyberpunk workflow
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
        "text/plain" = "org.gnome.TextEditor.desktop";
        "application/json" = "code.desktop";
        "text/markdown" = "code.desktop";
        "image/jpeg" = "imv.desktop";
        "image/png" = "imv.desktop";
        "image/gif" = "imv.desktop";
        "image/webp" = "imv.desktop";
        "video/mp4" = "mpv.desktop";
        "video/mkv" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "audio/mp3" = "mpv.desktop";
        "audio/flac" = "mpv.desktop";
        "audio/ogg" = "mpv.desktop";
        "inode/directory" = "org.gnome.Nautilus.desktop";
      };
    };
  };

  # GTK theme for consistent cyberpunk look
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
    font = {
      name = "JetBrains Mono";
      size = 11;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Qt theme for consistent cyberpunk look
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  # Home Manager settings
  home = {
    username = "meeast";
    homeDirectory = "/home/meeast";
    stateVersion = "24.05";
    
    # Environment variables for cyberpunk desktop
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      
      # Wayland-specific
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      
      # Cyberpunk theme variables
      CYBERPUNK_THEME = "enabled";
      HYPRLAND_CYBERPUNK = "true";
    };
  };

  # Create cyberpunk directories structure
  home.file = {
    "Pictures/Wallpapers/.keep".text = "";
    ".config/cyberpunk/.keep".text = "";
    ".local/share/cyberpunk/.keep".text = "";
  };

  # Enable services
  services = {
    # Automatic screen locker
    swayidle = {
      enable = true;
      events = [
        { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock --color 1a1625"; }
        { event = "lock"; command = "${pkgs.swaylock-effects}/bin/swaylock --color 1a1625"; }
      ];
      timeouts = [
        { timeout = 300; command = "${pkgs.swaylock-effects}/bin/swaylock --color 1a1625"; }
        { timeout = 600; command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off"; resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on"; }
      ];
    };
    
    # Clipboard manager
    cliphist.enable = true;
    
    # Network manager applet
    network-manager-applet.enable = true;
    
    # Bluetooth manager
    blueman-applet.enable = true;
  };

  # Program configurations
  programs = {
    # Enable home manager
    home-manager.enable = true;
    
    # Shell integration
    bash.enable = true;
    zsh.enable = true;
    
    # Development tools
    git.enable = true;
    
    # Basic utilities
    direnv.enable = true;
    fzf.enable = true;
    bat.enable = true;
    eza.enable = true;
    
    # Media
    mpv.enable = true;
  };

  # Systemd user services for cyberpunk enhancements
  systemd.user.services = {
    # Auto-wallpaper rotation disabled - using manual switching with Super+W instead
  };
}