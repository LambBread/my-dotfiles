{
    pkgs,
    stdenv,
    fetchzip,
}:
let
    colors = import ./colors.nix;
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
in
stdenv.mkDerivation rec {
    pname = "qogir-theme-fork";
    version = "2026-08-06";
    dontBuild = true;
    nativeBuildInputs = [ pkgs.gowall ];
    src = fetchzip {
        url = "https://github.com/LambBread/Qogir-theme/releases/download/2026-08-06/Qogir-Custom-Dark.zip";
        sha256 = "sha256-hB5sgXfQuA+GI+v2ywKC3jNlSXTLrhzo0f8lTUq4hbs=";
        stripRoot = false;
    };
    installPhase = ''
        export HOME=$NIX_BUILD_TOP
        mkdir -p $HOME/.config/gowall
        cp ${gowallTheme} $HOME/.config/gowall/config.yml
        mkdir -p $out/share/themes
        cp -r Qogir-Custom-Dark $out/share/themes
        find . -type f -name "*.png" -exec gowall convert {} -t my-custom --output {} --preview false \;
    '';
}
