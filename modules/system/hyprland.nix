{ config, pkgs, ... }:
{
  # Activer Hyprland au niveau système
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Configuration greetd avec tuigreet pour écran de connexion
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${pkgs.hyprland}/bin/Hyprland";
        user = "greeter";
      };
    };
  };

  # Désactiver getty sur tty1 pour éviter les conflits
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  

  # Support XDG et Wayland amélioré
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk # pour la compatibilité
    ];
    config.common.default = "*";
  };

  # Services desktop (maintenant que XDG portal est activé)
  services.flatpak.enable = true;

  # Variables d'environnement Wayland étendues
  environment.sessionVariables = {
    # Wayland
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    
    # Qt
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    
    # GTK
    GDK_BACKEND = "wayland,x11";
    
    # SDL
    SDL_VIDEODRIVER = "wayland";
    
    # Firefox
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Support graphique amélioré
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Services système nécessaires
  security.polkit.enable = true;
  services.dbus.enable = true;
  
  # Support GVFS pour les montages automatiques
  services.gvfs.enable = true;
  
  # Support udisks2 pour la gestion des disques
  services.udisks2.enable = true;

  # Packages Hyprland étendus
  environment.systemPackages = with pkgs; [
    # Hyprland core
    hyprland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    
    # Wayland utilities
    # waybar géré par Home Manager
    wofi
    kitty
    wl-clipboard
    grim
    slurp
    swww
    swaylock-effects
    
    # Notifications et audio
    mako
    pavucontrol
    
    # File manager et utilitaires
    nautilus
    file-roller
    
    # Polices et thèmes
    adwaita-icon-theme
    pkgs.gnome-themes-extra
    
    # Debug et monitoring
    wlr-randr
    wayland-utils
  ];
}
