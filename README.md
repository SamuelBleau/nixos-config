# NixOS Configuration - Meeast

Une configuration NixOS modulaire et flexible inspirée des bonnes pratiques comme HydeNix.

## 🚀 Installation rapide

```bash
# Cloner la configuration
git clone https://github.com/YOUR_USERNAME/nixos-config /etc/nixos
cd /etc/nixos

# Copier votre hardware-configuration.nix
sudo nixos-generate-config --dir /tmp
cp /tmp/hardware-configuration.nix hosts/meeast-laptop/

# Appliquer la configuration
sudo nixos-rebuild switch --flake .#meeast-laptop
```

## 📁 Structure

```
/etc/nixos/
├── flake.nix              # Point d'entrée principal
├── lib/                   # Bibliothèques personnalisées
│   ├── default.nix
│   └── themes.nix         # Système de thèmes centralisé
├── hosts/                 # Configurations spécifiques aux machines
│   └── meeast-laptop/
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── modules/
│   ├── home/              # Configuration Home Manager
│   │   ├── default.nix    # Configuration principale utilisateur
│   │   ├── options.nix    # Options configurables
│   │   ├── desktop-new.nix # Environnement de bureau
│   │   ├── development.nix # Outils de développement
│   │   ├── terminal.nix   # Configuration terminaux
│   │   ├── apps/          # Applications spécifiques
│   │   ├── desktop/       # Composants desktop (Hyprland, Waybar, etc.)
│   │   ├── terminal/      # Configurations terminaux
│   │   └── themes/        # Thèmes disponibles
│   └── system/            # Configuration système NixOS
│       ├── base.nix       # Configuration de base
│       ├── desktop.nix    # Bureau système
│       ├── hyprland.nix   # Hyprland système
│       ├── devtools.nix   # Outils développement système
│       └── laptop.nix     # Configuration laptop
└── assets/                # Ressources (wallpapers, fonts, etc.)
```

## Configuration modulaire

### Options disponibles

Toutes les options sont définies sous `meeast.*` dans `modules/home/options.nix`:

```nix
meeast = {
  desktop = {
    enable = true;                    # Activer l'environnement de bureau
    theme = "cyberpunk";             # Thème à utiliser
    hyprland = {
      enable = true;                 # Activer Hyprland
      animations.enable = true;      # Animations
      gaps = {
        inner = 8;                   # Espacement intérieur
        outer = 24;                  # Espacement extérieur
      };
      borderSize = 2;               # Taille des bordures
    };
    waybar = {
      enable = true;                # Activer Waybar
      position = "top";             # Position: "top" ou "bottom"
      height = 36;                  # Hauteur en pixels
    };
  };
  
  terminal = {
    default = "kitty";              # Terminal par défaut
    opacity = 0.9;                  # Opacité (0.0 à 1.0)
  };
  
  development = {
    enable = true;                  # Outils de développement
    vscode.enable = true;           # VS Code
    git.enable = true;              # Configuration Git
  };
};
```

### Personnalisation

#### Changer l'opacité du terminal
```nix
meeast.terminal.opacity = 0.8;
```

#### Modifier les espaces Hyprland
```nix
meeast.desktop.hyprland.gaps = {
  inner = 12;
  outer = 20;
};
```

#### Déplacer Waybar en bas
```nix
meeast.desktop.waybar.position = "bottom";
```

#### Désactiver les animations
```nix
meeast.desktop.hyprland.animations.enable = false;
```

## Système de thèmes

Les thèmes sont centralisés dans `lib/themes.nix` et automatiquement passés à tous les modules via `theme.*`.

### Couleurs disponibles
- `theme.primary.cyan`
- `theme.primary.magenta` 
- `theme.primary.yellow`
- `theme.ui.background`
- `theme.ui.surface`
- `theme.text.primary`
- Etc.

## Utilisation

### Build et switch
```bash
sudo nixos-rebuild switch --flake .#meeast-laptop
```

### Test de la configuration
```bash
nix flake check
```

### Build sans installer
```bash
nix build .#nixosConfigurations.meeast-laptop.config.system.build.toplevel
```

### Shell de développement
```bash
nix develop  # Accès à nixfmt, statix, deadnix
```

## Ajout de nouveaux modules

1. Créer le module dans le bon dossier (`apps/`, `desktop/`, etc.)
2. Ajouter les options dans `options.nix` si nécessaire
3. Importer dans le module parent approprié
4. Utiliser `mkIf` pour rendre conditionnel si besoin

## Avantages de cette architecture

- ✅ **Modulaire**: Chaque composant est indépendant
- ✅ **Configurable**: Options centralisées et documentées  
- ✅ **Maintenable**: Structure claire et séparation des responsabilités
- ✅ **Réutilisable**: Facile d'adapter pour d'autres machines
- ✅ **Thèmes centralisés**: Un seul endroit pour les couleurs
- ✅ **Type-safe**: Validation des options par Nix