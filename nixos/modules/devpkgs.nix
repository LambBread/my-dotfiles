{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs;
    [
        gcc
        gnumake
        ninja
        cmake
        emscripten
        clang-tools
        python3
    ];
}
