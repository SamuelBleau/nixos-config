# Template pour créer un nouveau host

Pour ajouter une nouvelle machine à cette configuration :

## 1. Créer le dossier host
```bash
mkdir -p hosts/NOUVEAU-HOST
```

## 2. Créer la configuration
```nix
# hosts/NOUVEAU-HOST/default.nix
{ config, pkgs, lib, theme, ... }:

{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
```

```nix
# hosts/NOUVEAU-HOST/configuration.nix
{ config, pkgs, lib, theme, ... }:

{
  imports = [
    ../../modules/system/base.nix
    ../../modules/system/desktop.nix
    ../../modules/system/hyprland.nix
    # Ajouter d'autres modules selon les besoins
  ];

  # Configuration spécifique à cette machine
  networking.hostName = "NOUVEAU-HOST";

  # Utilisateurs
  users.users.USERNAME = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
  };

  system.stateVersion = "24.05";
}
```

## 3. Générer hardware-configuration.nix
```bash
sudo nixos-generate-config --dir /tmp
cp /tmp/hardware-configuration.nix hosts/NOUVEAU-HOST/
```

## 4. Ajouter au flake.nix
```nix
nixosConfigurations = {
  meeast-laptop = # ... configuration existante
  
  NOUVEAU-HOST = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = specialArgs;
    modules = [
      ./hosts/NOUVEAU-HOST
      # modules communs...
    ];
  };
};
```

## 5. Construire et appliquer
```bash
sudo nixos-rebuild switch --flake .#NOUVEAU-HOST
```