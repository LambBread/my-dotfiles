{
    config,
    pkgs,
    lib,
    ...
}:
let
    personal = import ../personal.nix;
    colors = import ./colors.nix;
    backgroundImg = pkgs.fetchurl {
        # https://www.reddit.com/r/VaporwaveAesthetics/comments/1t9j5ya/blue_city/
        url = "https://i.redd.it/szhyd7ryld0h1.png";
        sha256 = "1dgsza18k6n5jjkphzzwyrg3sqdy1ln6smnvh724x15n9yflx9ff";
    };
    gowallTheme = pkgs.writeText "gowall-config.yml" ''
        themes:
          - name: "my-custom"
            colors:
              - "#${colors.black}" 
              - "#${colors.red}"  
              - "#${colors.green}"  
              - "#${colors.yellow}"  
              - "#${colors.blue}"  
              - "#${colors.magenta}"  
              - "#${colors.cyan}" 
              - "#${colors.white}"  
              - "#${colors.l_black}" 
              - "#${colors.l_red}"  
              - "#${colors.l_green}"  
              - "#${colors.l_yellow}"  
              - "#${colors.l_blue}"  
              - "#${colors.l_magenta}"  
              - "#${colors.l_cyan}" 
              - "#${colors.l_white}"'';

    processedBackground =
        pkgs.runCommand "processed-background.png"
            {
                nativeBuildInputs = [ pkgs.gowall ];
            }
            ''
                export HOME=$NIX_BUILD_TOP
                mkdir -p $HOME/.config/gowall
                cp ${gowallTheme} $HOME/.config/gowall/config.yml
                gowall convert ${backgroundImg} --output $out -t my-custom --preview false
            '';

    rowaita-icon-theme = pkgs.callPackage ./rowaita.nix { };
    qogir-theme-fork = pkgs.callPackage ./qogir.nix { };
in
{
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernel.sysctl."vm.swappiness" = 20;
    networking.hostName = "${personal.SHORT_NAME}-${personal.DESK_NAME}"; # Define your hostname.
    # Enable networking
    networking.networkmanager.enable = true;
    programs.nm-applet.enable = true;

    # Set your time zone.
    time.timeZone = "America/Vancouver";
    i18n.defaultLocale = "en_CA.UTF-8";
    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    # nix.settings.auto-optimise-store = true;

    systemd.tmpfiles.rules = [
        "L+ /srv/background.png - - - - ${processedBackground}"
    ];

    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        config.common.default = "*";
    };

    nix.gc = {
        automatic = true;
        dates = "02:00";
        options = "--delete-older-than 14d";
    };

    nix.optimise = {
        automatic = true;
        dates = "03:00";
    };

    services.kmscon = {
        enable = true;
        hwRender = true;
        # config = {
        #     hwaccel = true;
        #     font-name = "MonaspiceAr Nerd Font Mono";
        #     font-size = 14;
        #     palette = "custom";
        #     palette-background = "65,40,83";
        #     palette-foreground = "236,227,213";

        #     palette-black = "65,40,83";
        #     palette-red = "240,133,51";
        #     palette-green = "101,146,38";
        #     palette-yellow = "174,172,30";
        #     palette-blue = "36,91,151";
        #     palette-magenta = "151,104,182";
        #     palette-cyan = "3,173,145";
        #     palette-white = "207,183,147";

        #     palette-light-black = "114,100,124";
        #     palette-light-red = "208,114,113";
        #     palette-light-green = "159,211,86";
        #     palette-light-yellow = "224,222,75";
        #     palette-light-blue = "107,151,219";
        #     palette-light-magenta = "188,158,208";
        #     palette-light-cyan = "54,252,219";
        #     palette-light-white = "236,227,213";
        # }
        extraOptions = "--term xterm-256color --seats seat0";
        extraConfig = ''
            font-name=${colors.font}
            font-size=14

            palette=custom

            palette-background=${colors.hexToRgbStr "${colors.black}"}
            palette-foreground=${colors.hexToRgbStr "${colors.l_white}"}

            palette-black=${colors.hexToRgbStr "${colors.black}"}
            palette-red=${colors.hexToRgbStr "${colors.red}"}
            palette-green=${colors.hexToRgbStr "${colors.green}"}
            palette-yellow=${colors.hexToRgbStr "${colors.yellow}"}
            palette-blue=${colors.hexToRgbStr "${colors.blue}"}
            palette-magenta=${colors.hexToRgbStr "${colors.magenta}"}
            palette-cyan=${colors.hexToRgbStr "${colors.cyan}"}
            palette-white=${colors.hexToRgbStr "${colors.white}"}

            palette-light-black=${colors.hexToRgbStr "${colors.l_black}"}
            palette-light-red=${colors.hexToRgbStr "${colors.l_red}"}
            palette-light-green=${colors.hexToRgbStr "${colors.l_green}"}
            palette-light-yellow=${colors.hexToRgbStr "${colors.l_yellow}"}
            palette-light-blue=${colors.hexToRgbStr "${colors.l_blue}"}
            palette-light-magenta=${colors.hexToRgbStr "${colors.l_magenta}"}
            palette-light-cyan=${colors.hexToRgbStr "${colors.l_cyan}"}
            palette-light-white=${colors.hexToRgbStr "${colors.l_white}"}
        '';
    };

    systemd.services."kmscon@tty7".enable = false;

    programs.appimage.enable = true;
    programs.appimage.binfmt = true;
    services.gnome.gnome-keyring.enable = true;

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };
    programs.thunar = {
        enable = true;
        plugins = with pkgs; [
            thunar-archive-plugin
            thunar-volman
        ];
    };
    programs.dconf.enable = true;
    # services.zeitgeist.enable = true;
    services.gvfs.enable = true;
    services.greenclip.enable = true;
    services.tumbler.enable = true;
    services.udisks2.enable = true;
    security.polkit.enable = true;
    services.envfs.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };
    services.pulseaudio = {
        enable = false;
        support32Bit = false;
        package = pkgs.pulseaudioFull;
    };

    services.displayManager = {
        defaultSession = "none+bspwm";
    };
    services.xserver = {
        enable = true;

        displayManager.lightdm = {
            enable = true;
            background = "${processedBackground}";
            greeters.gtk = {
                enable = true;
                theme.name = "${colors.theme}";
                iconTheme.name = "${colors.icon_theme}";
                cursorTheme.name = "${colors.cursor_theme}";
                extraConfig = ''
                    font-name = ${colors.font} 12
                    clock-format = %Y-%m-%d %H:%M:%S
                '';
            };
            extraConfig = ''
                logind-check-graphical=true
                [LightDM]
                minimum-vt=7

            '';
        };
        windowManager.bspwm = {
            enable = true;
        };
    };
    services.blueman.enable = true;
    services.dbus.enable = true;
    # services.dbus.packages = [ pkgs.diodon pkgs.zeitgeist ];
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
    environment.sessionVariables = {
        TERMINAL = "ghostty";
        # XCURSOR_THEME = "Adwaita";
    };
    #environment.variables = {
    #    XCURSOR_PATH = lib.mkForce "$HOME/.icons:$HOME/.local/share/icons:/run/current-system/sw/share/icons";
    #};
    xdg.terminal-exec.settings = {
        default = [ "com.mitchellh.ghostty.desktop" ];
    };
}
