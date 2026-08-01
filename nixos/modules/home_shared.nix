{ config, pkgs, ... }:
{
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

    programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings = 
        {
            "github.com" = 
            {
                HostName = "github.com";
                User = "git";
                IdentityFile = "~/.ssh/gh_key2";
                IdentitiesOnly = "yes";
            };
        };
    };
    
    xdg.userDirs =
    {
        enable = true;
        createDirectories = true;

        desktop = "${config.home.homeDirectory}/Desktop";
        download = "${config.home.homeDirectory}/Downloads";
        documents = "${config.home.homeDirectory}/Documents";
        music = "${config.home.homeDirectory}/Music";
        pictures = "${config.home.homeDirectory}/Pictures";
        videos = "${config.home.homeDirectory}/Videos";
        extraConfig = 
        {
            XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
        };
    };
}
