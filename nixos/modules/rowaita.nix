{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec
{
    pname = "rowaita-icon-theme";
    version = "1.2.5";
    dontCheckForBrokenSymlinks = true;
    dontBuild = true;
    src = fetchFromGitHub
    {
        owner = "LambBread";
        repo = "rowaita-icon-theme";
        rev = "main";
        sha256 = "sha256-THVxqpoqyBcVZbpckWVntw/PRAbKC58mWx6rbcsQo5E=";
    };
    installPhase =
    ''
        mkdir -p $out/share/icons
        cp -r Rowaita* $out/share/icons
    '';
}
