{
    config,
    pkgs,
    lib,
    colors,
    personal,
    ...
}:
let
    backgroundImg = pkgs.fetchurl {
        # https://www.reddit.com/r/VaporwaveAesthetics/comments/1t9j5ya/blue_city/
        # url = "https://i.redd.it/szhyd7ryld0h1.png";
        # sha256 = "1dgsza18k6n5jjkphzzwyrg3sqdy1ln6smnvh724x15n9yflx9ff";

        # https://www.reddit.com/r/wallpapers/comments/1w3h8ik/starry_sky_2560x1440/
        # url = "https://i.redd.it/liz4vv6ybqmh1.jpeg";
        # hash = "sha256-VmrZZLi8wRW14kL7nCcmr7uCn0567ZIpv39u/H/oHBI=";

        # https://www.reddit.com/r/wallpapers/comments/1vmryqi/reflection_of_a_thousand_blossoms/
        url = "https://i.redd.it/bmlzwcuym0jh1.jpeg";
        sha256 = "sha256-xkC47XmheqYp8kIyixn+3WFIkGW2AP5jSfUNRa+ZrZs=";
    };

    processedBackground =
        pkgs.runCommand "processed-background.png"
            {
                nativeBuildInputs = [ pkgs.gowall ];
            }
            ''
                export HOME=$NIX_BUILD_TOP
                mkdir -p $HOME/.config/gowall
                cp ${colors.gowallTheme} $HOME/.config/gowall/config.yml
                gowall convert ${backgroundImg} --output $out -t my-custom --preview false
            '';

in
{
    imports = [
        ./clean.nix
        ./commonpkgs.nix
        ./kmscon.nix
        ./nixvim.nix
    ];

    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];
    networking.hostName = "${personal.SHORT_NAME}-${personal.DESK_NAME}"; # Define your hostname.

    # Set your time zone.
    time.timeZone = "America/Vancouver";
    i18n.defaultLocale = "en_CA.UTF-8";

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernel.sysctl = {
        "vm.swappiness" = 150;
        "vm.watermark_boost_factor" = 0;
        "vm.watermark_scale_factor" = 125;
        "vm.page-cluster" = 0;
    };
    boot.plymouth = {
        enable = true;
        theme = "nixos-bgrt";
        themePackages = with pkgs; [
            nixos-bgrt-plymouth
        ];
    };

    boot.kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "vt.global_cursor_default=0"
        "udev.log_priority=3"
    ];

    zramSwap = {
        enable = true;
        algorithm = "zstd";
        memoryPercent = 100;
        priority = 100;
    };
    systemd.oomd.enable = true;

    # nix.settings.auto-optimise-store = true;

    systemd.tmpfiles.rules = [
        "L+ /srv/background.png - - - - ${processedBackground}"
    ];

    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        config.common.default = "*";
    };
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };
    programs.dconf.enable = true;

    # Enable networking
    networking.networkmanager.enable = true;
    programs.nm-applet.enable = true;

    programs.appimage.enable = true;
    programs.appimage.binfmt = true;
    security.polkit.enable = true;
    services.blueman.enable = true;
    services.dbus.enable = true;
    services.envfs.enable = true;
    services.greenclip.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;
    services.udisks2.enable = true;
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
    # services.dbus.packages = [ pkgs.diodon pkgs.zeitgeist ];
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
    environment.sessionVariables = {
        TERMINAL = "ghostty";
        # XCURSOR_THEME = "Adwaita";
    };
    xdg.terminal-exec.settings = {
        default = [ "com.mitchellh.ghostty.desktop" ];
    };
}
