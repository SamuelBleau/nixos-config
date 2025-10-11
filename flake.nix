{
  description = "Meeast's NixOS configuration";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, home-manager, hyprland, nix-flatpak, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      
      # Custom lib with our theme system
      lib = nixpkgs.lib.extend (final: prev: {
        custom = import ./lib { lib = final; };
        hm = home-manager.lib.hm;
      });
      
      # Common special args for all configurations
      specialArgs = { 
        inherit hyprland lib;
        theme = lib.custom.themes.default;
      };
    in
    {
      # Host configurations
      nixosConfigurations = {
        meeast-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = specialArgs;
          modules = [
            ./hosts/meeast-laptop
            
            nix-flatpak.nixosModules.nix-flatpak
            
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.meeast = import ./modules/home;
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };
      };
      
      # Development shell
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixfmt-rfc-style
          statix
          deadnix
        ];
      };
    };
}
