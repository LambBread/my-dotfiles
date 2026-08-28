{
    config,
    pkgs,
    lib,
    ...
}:
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

    home.file = lib.mkMerge [
        (builtins.mapAttrs (key: value: {
            source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${value}";
            force = true;
        }) links)

        {
            ".Xmodmap".text = ''
                clear Lock
                keycode 66 = Hyper_L
                keycode 171 = Caps_Lock XF86AudioNext
                keycode 108 = Multi_key Alt_R
                remove mod4 = Hyper_L
                add mod3 = Hyper_L
            '';
        }
    ];

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
