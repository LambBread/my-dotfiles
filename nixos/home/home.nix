{
    config,
    pkgs,
    lib,
    ...
}:
let
    personal = import ../personal.nix;
in
{
    imports = [
        ./home_shared.nix
    ];

    home.stateVersion = "26.05";
    home.packages = with pkgs; [

    ];

    home.file.".Xmodmap".text = ''
        clear Lock
        keycode 66 = Hyper_L
        keycode 78 = Caps_Lock Scroll_Lock
        keycode 135 = Multi_key Menu
        remove mod4 = Hyper_L
        add mod3 = Hyper_L
    '';

    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "${personal.USERNAME}";
                email = "${personal.EMAIL}";
                signingkey = "${config.home.homeDirectory}/.ssh/gh_key.pub";
            };
            signing = {
                key = "${config.home.homeDirectory}/.ssh/gh_key.pub";
                signByDefault = true;
                format = "ssh";
            };
            commit = {
                gpgSign = true;
            };
            gpg = {
                format = "ssh";
            };
        };
    };

}
