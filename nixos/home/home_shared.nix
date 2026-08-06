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

    home.activation.configureThunar = ''
        ${pkgs.xfconf}/bin/xfconf-query --channel thunar --property /last-show-hidden --create --type bool --set true
        ${pkgs.xfconf}/bin/xfconf-query --channel thunar --property /last-icon-view-zoom-level --create --type string --set THUNAR_ZOOM_LEVEL_75_PERCENT
        ${pkgs.xfconf}/bin/xfconf-query --channel thunar --property /last-menubar-visible --create --type bool --set false
    '';

    programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings = {
            "github.com" = {
                HostName = "github.com";
                User = "git";
                IdentityFile = "~/.ssh/gh_key2";
                IdentitiesOnly = "yes";
            };
        };
    };

    xdg.userDirs = {
        enable = true;
        createDirectories = true;

        desktop = "${config.home.homeDirectory}/Desktop";
        download = "${config.home.homeDirectory}/Downloads";
        documents = "${config.home.homeDirectory}/Documents";
        music = "${config.home.homeDirectory}/Music";
        pictures = "${config.home.homeDirectory}/Pictures";
        videos = "${config.home.homeDirectory}/Videos";
        extraConfig = {
            XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
        };
    };

    xdg.configFile."Thunar/uca.xml".text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <actions>
          <action>
            <icon>utilities-terminal</icon>
            <name>Open Terminal Here</name>
            <submenu></submenu>
            <unique-id>1785700247397756-1</unique-id>
            <command>ghostty --working-directory=&quot;%d&quot;</command>
            <description>Open Ghostty in the current directory</description>
            <range>*</range>
            <patterns>*</patterns>
            <startup-notify/>
            <directories/>
          </action>
          <action>
            <icon>nvim</icon>
            <name>Open Neovim Here</name>
            <submenu></submenu>
            <unique-id>1785700247397770-2</unique-id>
            <command>ghostty --working-directory=&quot;%d&quot; --command=&quot;nvim &apos;%f&apos;&quot;</command>
            <description>Open Neovim in Ghostty</description>
            <range></range>
            <patterns>*</patterns>
            <directories/>
            <text-files/>
            <other-files/>
          </action>
        </actions>
    '';
}
