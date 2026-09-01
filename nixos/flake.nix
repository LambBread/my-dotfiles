{
    description = "A riced NixOS config with bspwm";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
            url = "github:nix-community/nixvim/nixos-26.05";
            #inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs =
        {
            self,
            nixpkgs,
            home-manager,
            nixvim,
            ...
        }@inputs:
        let
            personal = import ./personal.nix;
        in
        {
            nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    ./configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.${personal.SHORT_NAME} = import ./home/home.nix;
                    }
                    nixvim.nixosModules.nixvim
                ];
            };
            nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    ./configuration_laptop.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.${personal.SHORT_NAME} = import ./home/home_laptop.nix;
                    }
                ];
            };
        };

}
