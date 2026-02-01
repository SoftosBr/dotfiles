{
  description = "Softosbr's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    }
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        }
      }
      ;
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ 
            ./hosts/desktop/configuration.nix 
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nix-user = {
                imports = [
                  ./home/home.nix
                ];
              };
              home-manager.extraSpecialArgs = { username = "nix-user"; inputs = inputs; };
            }
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ 
            ./hosts/laptop/configuration.nix 
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nix-user = {
                imports = [
                  ./home/home.nix
                ];
              };
              home-manager.extraSpecialArgs = { username = "nix-user"; inputs = inputs; };
            }
          ];
        };
      };
    };    
  };
}