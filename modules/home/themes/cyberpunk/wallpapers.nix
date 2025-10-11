{ config, pkgs, lib, ... }:

{
  # Cyberpunk wallpaper management
  home.file = {
    # Wallpaper directory structure
    "Pictures/Wallpapers/cyberpunk/.keep".text = "";
    
    # Wallpaper configuration
    ".config/cyberpunk/wallpapers.conf".text = ''
      # Cyberpunk wallpaper configuration
      [default]
      wallpaper=/etc/nixos/assets/wallpapers/cyberpunk/night-city-main.jpg
      
      [collection]
      night_city=/etc/nixos/assets/wallpapers/cyberpunk/night-city-main.jpg
      braindance=/etc/nixos/assets/wallpapers/cyberpunk/braindance-terminal.jpg
      corpo_plaza=/etc/nixos/assets/wallpapers/cyberpunk/corpo-plaza.jpg
      netrunner=/etc/nixos/assets/wallpapers/cyberpunk/netrunner-setup.jpg
      
      [swww]
      transition_type=fade
      transition_duration=3
      fps=60
    '';
  };
  
  # Ensure swww is available for wallpaper management
  home.packages = with pkgs; [
    swww
  ];
}