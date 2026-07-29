{ config, pkgs, ... }:
let
    personal = import ./personal.nix;
    backgroundImg = pkgs.fetchurl
    {
      url = "https://i.redd.it/szhyd7ryld0h1.png";
      sha256 = "1dgsza18k6n5jjkphzzwyrg3sqdy1ln6smnvh724x15n9yflx9ff";
    };
in
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  systemd.tmpfiles.rules = 
  [
    "L+ /srv/background.png - - - - ${backgroundImg}"
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${personal.SHORT_NAME} = import ./home_laptop.nix;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
    programs.thunar.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;
    services.pipewire.enable = false;
    services.envfs.enable = true;
    services.pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
    
    services.displayManager = {
      defaultSession = "none+bspwm";
    };
    services.xserver = {
      enable = true;
    
      displayManager.lightdm = 
      {
        enable = true;
        greeters.gtk = 
        {
            enable = true;
            theme = {
                name = "Qogir-Dark";
                package = pkgs.qogir-theme;
            };
            iconTheme = {
                name = "Adwaita-Dark";
                package = pkgs.gnome-themes-extra;
            };
            cursorTheme = {
                name = "Adwaita";
                package = pkgs.gnome-themes-extra;
            };
            background = "${backgroundImg}";
        };
      };
      windowManager.bspwm = {
        enable = true;
      };
    };
    services.blueman.enable = true;
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
    environment.sessionVariables = {
        TERMINAL = "ghostty";
    };
    xdg.terminal-exec.settings = {
        default = [ "com.mitchellh.ghostty.desktop" ];
    };
}
