{
    config,
    pkgs,
    inputs,
    lib,
    ...
}:
{

    imports = [
        ./apps/bash
        ./apps/conky
        ./apps/ghostty
        ./apps/gtk
        ./apps/bspwm
        ./apps/librewolf.nix
        ./apps/misc.nix
    ];
    home.packages = with pkgs; [
        gsimplecal
        rofi
        feh
        (polybar.override {
            pulseSupport = true;
        })
        libreoffice
        vlc
        ristretto
        gimp
        atril
        prismlauncher
        fastfetch
        hyfetch
        tty-clock

    ];
    home.activation.makeDirectories = ''
        run mkdir -p ${config.home.homeDirectory}/Pictures/wallpaper
        run ln -sf /srv/background.png \
        ${config.home.homeDirectory}/Pictures/wallpaper/wallpaper.png
    '';

}
