{
    config,
    pkgs,
    lib,
    ...
}:
let
    personal = import ../personal.nix;
    backgroundImg = pkgs.fetchurl {
        # https://www.reddit.com/r/VaporwaveAesthetics/comments/1t9j5ya/blue_city/
        url = "https://i.redd.it/szhyd7ryld0h1.png";
        sha256 = "1dgsza18k6n5jjkphzzwyrg3sqdy1ln6smnvh724x15n9yflx9ff";
    };
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
        "L+ /srv/background.png - - - - ${backgroundImg}"
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

    programs.appimage.enable = true;
    programs.appimage.binfmt = true;
    services.gnome.gnome-keyring.enable = true;

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };
    programs.thunar.enable = true;
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
            background = "${backgroundImg}";
            greeters.gtk = {
                enable = true;
                theme = {
                    name = "Qogir-Custom-Dark";
                    package = qogir-theme-fork;
                };
                iconTheme = {
                    name = "Rowaita-Lavender-Dark";
                    package = rowaita-icon-theme;
                };
                cursorTheme = {
                    name = "Simp1e-Adw-Dark";
                    package = pkgs.simp1e-cursors;
                };
                extraConfig = ''
                    font-name = MonaspiceAr Nerd Font Mono 12
                    clock-format = %Y-%m-%d %H:%M:%S
                '';
            };
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
