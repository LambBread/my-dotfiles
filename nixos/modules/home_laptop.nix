{ config, pkgs, ... }:
let
    homeLinks = import ./home_links.nix;
    personal = import ../personal.nix;
    dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
    links = homeLinks.commonLinks // homeLinks.laptopLinks;
in
{
    imports = 
    [
        ./home_shared.nix;
    ];

    home.stateVersion = "26.05";
    home.packages = with pkgs;
    [

    ];
    home.activation.makeDirectories = ''
        run mkdir -p ${config.home.homeDirectory}/Pictures
        run mkdir -p ${config.home.homeDirectory}/Pictures/wallpaper
        run mkdir -p ${config.home.homeDirectory}/.config
        run mkdir -p ${config.home.homeDirectory}/.config/bspwm
        run mkdir -p ${config.home.homeDirectory}/.config/conky
        run mkdir -p ${config.home.homeDirectory}/.config/fastfetch
        run mkdir -p ${config.home.homeDirectory}/.config/polybar
        run ln -sf /srv/background.png \
        ${config.home.homeDirectory}/Pictures/wallpaper/wallpaper.png
    '';

    home.file = builtins.mapAttrs (key: value: {
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${value}";
        force = true;
    }) links;


    programs.git =
    {
        enable = true;
        settings =
        {
            user = 
            {
                name = "${personal.USERNAME}";
                email = "${personal.EMAIL}";
            };
            # signing = 
            # {
            #   key = "${config.home.homeDirectory}/.ssh/gh_key.pub";
            #   signByDefault = true;
            #   format = "ssh";
            # };
        };
    };
}
