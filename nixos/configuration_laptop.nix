# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  personal = import ./personal.nix;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "${personal.SHORT_NAME}-laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessaryn
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${personal.SHORT_NAME}" = {
    isNormalUser = true;
    description = "${personal.LONG_NAME}";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
    qogir-theme
    redshift
    diodon
    bleachbit
    prismlauncher
    (pkgs.thunar.override {
    	thunarPlugins = with pkgs; [
	  thunar-archive-plugin
	  thunar-volman
	];
    })
    file-roller
    ffmpegthumbnailer
    ristretto
    feh
    pavucontrol
    xfce4-screenshooter
  ];

services.gnome.games.enable = true;

fonts.packages = with pkgs; [
    nerd-fonts.monaspace
];

programs.neovim = {
  enable = true;
  defaultEditor = true;
};

programs.thunar.enable = true;
services.gvfs.enable = true;
services.tumbler.enable = true;
services.pipewire.enable = false;
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

  displayManager.lightdm.enable = true;
  windowManager.bspwm = {
    enable = true;
  };
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
