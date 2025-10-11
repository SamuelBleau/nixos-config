{ config, pkgs, lib, theme, ... }:

{
  imports = [
    ../../modules/system/base.nix
    ../../modules/system/desktop.nix
    ../../modules/system/hyprland.nix
    ../../modules/system/devtools.nix
    ../../modules/system/laptop.nix
  ];

  # Host-specific configuration
  networking.hostName = "meeast-laptop";

  # User configuration
  users.users.meeast = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    initialPassword = "Meeast6";
  };

  # NVIDIA configuration
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  # Wayland environment variables for NVIDIA
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_DRM_NO_ATOMIC = "1";
    XCURSOR_SIZE = "24";
  };

  # Flatpak configuration
  services.flatpak = {
    enable = true;
    remotes = [{
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
    }];
    packages = [];
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };

  system.stateVersion = "24.05";
}
