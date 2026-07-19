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
      ./settings.nix
    ];


  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${personal.SHORT_NAME}" = {
    isNormalUser = true;
    description = "${personal.LONG_NAME}";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };


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
    tmux
    gcc
    gnumake
    ninja
    cmake
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

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
