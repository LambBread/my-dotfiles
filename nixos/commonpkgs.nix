{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs;
    [
        sxhkd
        rofi
        conky
        xdo
        (polybar.override { 
        	pulseSupport = true;
        })
        dunst
        xsettingsd
        baobab
        librewolf
        libreoffice
        fastfetch
        wget
        git
        picom
        xmodmap
        ghostty
        _7zz
        xarchiver
        zip
        unzip
        qogir-theme
        redshift
        diodon
        bleachbit
        prismlauncher
        feh
        pavucontrol
        xfce4-screenshooter
        tmux
        (thunar.override
        {
        	thunarPlugins = with pkgs;
            [
	            thunar-archive-plugin
	            thunar-volman
	        ];
        })
        file-roller
        ffmpegthumbnailer
        ristretto
    ];
    fonts.packages = with pkgs; [
        nerd-fonts.monaspace
    ];
    
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
}
