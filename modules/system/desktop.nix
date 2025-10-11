{ config, pkgs, ... }:

{
  # Désactiver X11 en faveur de Wayland
  services.xserver.enable = false;
  services.desktopManager.gnome.enable = false;

  # Applications desktop essentielles
  environment.systemPackages = with pkgs; [
    firefox
    deezer-enhanced  # Client Deezer natif comme alternative à Flatpak
    # Hyprland et ses composants sont maintenant dans hyprland.nix
  ];

  # Services desktop
  services.printing.enable = true;
  
  # Support des polices
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
  ];
}
