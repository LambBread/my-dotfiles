{ stdenv, fetchzip }:
stdenv.mkDerivation rec {
    pname = "qogir-theme-fork";
    version = "2026-08-06";
    dontBuild = true;
    src = fetchzip
    {
        url = "https://github.com/LambBread/Qogir-theme/releases/download/2026-08-06/Qogir-Custom-Dark.zip";
        sha256 = "sha256-OubkMKL5iqDNE2vTjJ05QK83S81Zjytjkj2WX9D75cI=";
        stripRoot = false;
    };
    installPhase = ''
        mkdir -p $out/share/themes/Qogir-Custom-Dark
        cp -r . $out/share/themes/Qogir-Custom-Dark/
    '';
}
