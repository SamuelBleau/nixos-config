{ config, pkgs, ... }:

{
  # Bootloader configuration
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 5;
    efi.canTouchEfiVariables = true;
  };

  # Silent boot
  boot = {
    kernelParams = [
      "quiet" "splash" "loglevel=0"
      "systemd.show_status=auto" "udev.log_level=0"
      "rd.systemd.show_status=auto" "rd.udev.log_level=0"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  # Nix configuration
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Localization
  time.timeZone = "Europe/Paris";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  # Console
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  # Network
  networking.networkmanager.enable = true;
  # Essential services
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    openssh.enable = true;
  };

  # Audio with Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Essential programs
  programs = {
    zsh.enable = true;
    dconf.enable = true;
  };
  users.defaultUserShell = pkgs.zsh;

  # Base system packages
  environment.systemPackages = with pkgs; [
    wget curl git vim
    htop tree unzip p7zip
  ];

  # Firewall
  networking.firewall.enable = true;
}
