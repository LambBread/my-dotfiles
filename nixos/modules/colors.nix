rec {
    black = "412853";
    red = "f08533";
    green = "659226";
    yellow = "aeac1e";
    blue = "245b97";
    magenta = "9768b6";
    cyan = "03ad91";
    white = "cfb793";
    l_black = "72647c";
    l_red = "d07271";
    l_green = "9fd356";
    l_yellow = "e0de4b";
    l_blue = "6ba1db";
    l_magenta = "bc9ed0";
    l_cyan = "36fcdb";
    l_white = "ece3d5";
    black_alt = "0c1315"; # old black
    blue_alt = "205083"; # shaded blue
    #black = "402030";
    #red = "ff5874";
    #green = "23d18b";
    #yellow = "f1fa8c";
    #blue = "61afef";
    #magenta = "bd93f9";
    #cyan = "8be9fd";
    #white = "f8f8f2";
    #l_black = "6272a4";
    #l_red = "ff79c6";
    #l_green = "50fa7b";
    #l_yellow = "ffb86c";
    #l_blue = "b4f0ff";
    #l_magenta = "ff79c6";
    #l_cyan = "a4ffff";
    #l_white = "ffffff";
    #black_alt = "0f111a";
    #blue_alt = "245b97";

    theme = "Qogir-Custom-Dark";
    icon_theme = "Rowaita-Lavender-Dark";
    cursor_theme = "Simp1e-Adw-Dark";
    font = "MonaspiceAr Nerd Font Mono";
    emoji_font = "Noto Color Emoji";

    hexMap = {
        "0" = 0;
        "1" = 1;
        "2" = 2;
        "3" = 3;
        "4" = 4;
        "5" = 5;
        "6" = 6;
        "7" = 7;
        "8" = 8;
        "9" = 9;
        "a" = 10;
        "b" = 11;
        "c" = 12;
        "d" = 13;
        "e" = 14;
        "f" = 15;
        "A" = 10;
        "B" = 11;
        "C" = 12;
        "D" = 13;
        "E" = 14;
        "F" = 15;
    };

    hexPairToInt =
        pair:
        let
            char1 = builtins.substring 0 1 pair;
            char2 = builtins.substring 1 1 pair;
        in
        (hexMap.${char1} or 0) * 16 + (hexMap.${char2} or 0);

    # conversion function
    hexToRgb =
        hexStr:
        let
            # strip leading '#' if present
            cleanHex =
                if builtins.substring 0 1 hexStr == "#" then
                    builtins.substring 1 (builtins.stringLength hexStr - 1) hexStr
                else
                    hexStr;
        in
        {
            r = hexPairToInt (builtins.substring 0 2 cleanHex);
            g = hexPairToInt (builtins.substring 2 2 cleanHex);
            b = hexPairToInt (builtins.substring 4 2 cleanHex);
        };

    hexToRgbStr =
        hexStr:
        let
            rgb = hexToRgb hexStr;
        in
        "${toString rgb.r},${toString rgb.g},${toString rgb.b}";
}
