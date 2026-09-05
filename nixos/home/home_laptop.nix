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
        keycode 171 = Caps_Lock XF86AudioNext
        keycode 108 = Multi_key Alt_R
        remove mod4 = Hyper_L
        add mod3 = Hyper_L
    '';

}
