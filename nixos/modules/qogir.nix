{ stdenv, fetchzip }:
stdenv.mkDerivation rec {
    pname = "qogir-theme-fork";
    version = "2026-08-06";
    dontBuild = true;
    src = fetchzip
    {
        url = "https://github.com/LambBread/Qogir-theme/releases/download/2026-08-06/Qogir-Custom-Dark.zip";
        sha256 = "sha256-hB5sgXfQuA+GI+v2ywKC3jNlSXTLrhzo0f8lTUq4hbs=";
        stripRoot = false;
    };
    installPhase = ''
        mkdir -p $out/share/themes
        cp -r Qogir-Custom-Dark $out/share/themes
    '';
}
