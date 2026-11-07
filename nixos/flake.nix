{
    description = "A riced NixOS config with bspwm";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
        nix-colorizer.url = "github:nutsalhan87/nix-colorizer";
        nix-flatpak.url = "github:gmodena/nix-flatpak";
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
            nix-flatpak,
            ...
        }@inputs:
        let
            #personal = import ./personal.nix;

            mkThemePkg =
                system: colors:
                (qogir-theme-fork.lib.mkTheme {
                    black = "#${colors.black}";
                    red = "#${colors.red}";
                    magenta = "#${colors.magenta}";
                    l_red = "#${colors.l_red}";
                    l_green = "#${colors.l_green}";
                    l_white = "#${colors.l_white}";
                }).${system};

            mkSystem =
                hostname: system:
                let
                    pkgs = import nixpkgs { inherit system; };
                    personal = import ./personal.nix // {
                        DESK_NAME = hostname;
                    };
                    colors = import ./colors.nix { inherit pkgs inputs; };
                    qogir-theme-pkg = mkThemePkg system colors;
                in
                nixpkgs.lib.nixosSystem {
                    inherit system;
                    specialArgs = {
                        inherit
                            inputs
                            personal
                            colors
                            qogir-theme-pkg
                            ;
                    };
                    modules = [
                        ./hosts/${hostname}
                        ./modules
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.backupFileExtension = "bak";
                            home-manager.extraSpecialArgs = {
                                inherit
                                    inputs
                                    personal
                                    colors
                                    qogir-theme-pkg
                                    ;
                            };
                            home-manager.users.${personal.SHORT_NAME} = import ./hosts/${hostname}/home.nix;
                        }
                        nixvim.nixosModules.nixvim
                        nix-flatpak.nixosModules.nix-flatpak
                    ];
                };
        in
        {
            nixosConfigurations.desktop = mkSystem "desktop" "x86_64-linux";
            nixosConfigurations.laptop = mkSystem "laptop" "x86_64-linux";
        };

}
