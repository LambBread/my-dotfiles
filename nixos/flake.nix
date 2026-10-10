{
    description = "A riced NixOS config with bspwm";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
        nix-colorizer.url = "github:nutsalhan87/nix-colorizer";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
            url = "github:nix-community/nixvim/nixos-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        firefox-addons = {
            url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        qogir-theme-fork = {
            url = "github:LambBread/Qogir-theme";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        rowaita-icon-theme = {
            url = "github:LambBread/rowaita-icon-theme";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.nix-colorizer.follows = "nix-colorizer";
        };
    };
    outputs =
        {
            self,
            nixpkgs,
            home-manager,
            nixvim,
            firefox-addons,
            qogir-theme-fork,
            nix-colorizer,
            rowaita-icon-theme,
            ...
        }@inputs:
        let
            personal = import ./personal.nix;
            pkgs = import nixpkgs {
                system = "x86_64-linux";
            };

            colors = import ./colors.nix {
                inherit pkgs;
                inherit inputs;
            };
        in
        {
            nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = {
                    inherit inputs;
                    inherit personal;
                    inherit colors;
                };
                modules = [
                    ./hosts/desktop
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.backupFileExtension = "bak";
                        home-manager.extraSpecialArgs = {
                            inherit inputs;
                            inherit personal;
                            inherit colors;
                        };
                        home-manager.users.${personal.SHORT_NAME} = import ./hosts/desktop/home.nix;
                    }
                    nixvim.nixosModules.nixvim
                ];
            };
            nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    ./hosts/laptop
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.backupFileExtension = "bak";
                        home-manager.extraSpecialArgs = {
                            inherit inputs;
                            inherit personal;
                            inherit colors;
                        };
                        home-manager.users.${personal.SHORT_NAME} = import ./hosts/laptop/home.nix;
                    }
                    nixvim.nixosModules.nixvim
                ];
            };
        };

}
