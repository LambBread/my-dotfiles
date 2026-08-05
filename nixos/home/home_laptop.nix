{ config, pkgs, ... }:
let
    homeLinks = import ./home_links.nix;
    personal = import ../personal.nix;
    dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
    links = homeLinks.commonLinks // homeLinks.laptopLinks;
in
{
    imports = [
        ./home_shared.nix
    ];

    home.stateVersion = "26.05";
    home.packages = with pkgs; [

    ];

    home.file = builtins.mapAttrs (key: value: {
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${value}";
        force = true;
    }) links;

    programs.git = {
        enable = true;
        settings = {
            user = {
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
