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

    xdg.configFile."mimeapps.list".force = true;
    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "text/html" = "librewolf.desktop";
            "x-scheme-handler/http" = "librewolf.desktop";
            "x-scheme-handler/https" = "librewolf.desktop";
            "x-scheme-handler/about" = "librewolf.desktop";
            "x-scheme-handler/unknown" = "librewolf.desktop";
            "application/zip" = [ "xarchiver.desktop" ];
            "application/x-zip-compressed" = [ "xarchiver.desktop" ];
            "image/jpeg" = "org.xfce.ristretto.desktop";
            "image/png" = "org.xfce.ristretto.desktop";
            "image/gif" = "org.xfce.ristretto.desktop";
            "image/webp" = "org.xfce.ristretto.desktop";
            "image/svg+xml" = "org.xfce.ristretto.desktop";
        };
    };

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

    services.xsettingsd = {
        enable = true;
        settings = {
            "Net/ThemeName" = "Qogir-Custom-Dark";
            "Net/IconThemeName" = "Rowaita-Lavender-Dark";
            "Gtk/CursorThemeName" = "Simp1e-Adw-Dark";
            "Gtk/FontName" = "MonaspiceAr Nerd Font Mono 11";
        };
    };

    xdg.configFile."gsimplecal/config".text = ''
        show_week_numbers = 1
        mainwindow_yoffset = 90
        close_on_unfocus = 1
    '';

    programs.bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
            "cdu" = "cd ..";
            "cdp" = "cd -";
            "vim" = "nvim";
            "py3" = "python3";
            "clear" = "reset";
            "ls" = "ls -a --color=auto";
            "grep" = "grep --color=auto";
            "sl" = "ls -a --color=auto";
            "fastfetch" = "printf '\\n' && fastfetch";
            "rm" = "rm -v";
            "cp" = "cp -v";
            "mv" = "mv -v";
            "btw" = "echo \"I use $(. /etc/os-release; echo $NAME), Neovim, and bspwm btw\"";
            "nrs" = "sudo nixos-rebuild switch";
            "nrsl" = "sudo nixos-rebuild switch -Inixos-config=/etc/nixos/configuration_laptop.nix";
            "ncg" = "sudo nix-collect-garbage";
        };
        initExtra = ''
            eval "$(dircolors -b ~/.dircolors)"
            PS1='\[\033[00;95m\]\[\033[00;01;105m\] \u\[\033[00;95;44m\]\[\033[00;01;44m\] \w \[\033[00;34;47m\]\[\033[37;102m\]\[\033[92;101m\]\[\033[91;41m\]\[\033[00;01;41m\]  \A\[\033[00;31m\] \[\033[00m\] '
        '';
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
