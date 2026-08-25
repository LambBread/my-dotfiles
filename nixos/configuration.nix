# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
    personal = import ./personal.nix;
in
{

    imports = [
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ./modules/settings.nix
        ./modules/commonpkgs.nix
        <home-manager/nixos>
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."${personal.SHORT_NAME}" = {
        isNormalUser = true;
        description = "${personal.LONG_NAME}";
        extraGroups = [
            "networkmanager"
            "wheel"
            "audio"
            "video"
            "input"
            "libvirtd"
        ];
        packages = with pkgs; [ ];
    };

    fileSystems."/mnt/stuff" = {
        device = "/dev/disk/by-uuid/49de2a1b-812d-4a23-add5-fd01fd09d78f";
        fsType = "ext4";
        options = [
            "defaults"
            "nofail"
        ];
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        inkscape
        freecad
        simplescreenrecorder
        proton-vpn-cli
        proton-vpn
        dnsmasq
        luckybackup
        ungoogled-chromium
        pince
    ];

    networking.firewall.checkReversePath = false;
    services.flatpak.enable = true;

    programs.steam = {
        enable = true;
        extraPackages = with pkgs; [
            simp1e-cursors
        ];
    };

    services.xserver.videoDrivers = [ "nvidia" ];
    services.xserver.dpi = 96;
    services.thermald.enable = true;
    hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.${personal.SHORT_NAME} = import ./home/home.nix;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

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
