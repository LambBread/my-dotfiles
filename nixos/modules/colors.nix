{ pkgs, ... }:
rec {
    # typical

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

    # vga

    # black = "000000";
    # red = "aa0000";
    # green = "00aa00";
    # yellow = "aa5500";
    # blue = "0000aa";
    # magenta = "aa00aa";
    # cyan = "00aaaa";
    # white = "aaaaaa";
    # l_black = "555555";
    # l_red = "ff5555";
    # l_green = "55ff55";
    # l_yellow = "ffff55";
    # l_blue = "5555ff";
    # l_magenta = "ff55ff";
    # l_cyan = "55ffff";
    # l_white = "ffffff";
    # black_alt = "000000";

    # vscode

    # black = "000000";
    # red = "cd3131";
    # green = "0dbc79";
    # yellow = "e5e510";
    # blue = "2472c8";
    # magenta = "bc3fbc";
    # cyan = "11a8cd";
    # white = "e5e5e5";
    # l_black = "666666";
    # l_red = "f14c4c";
    # l_green = "23d187";
    # l_yellow = "f5f543";
    # l_blue = "3b8eea";
    # l_magenta = "d670d6";
    # l_cyan = "29d8b8";
    # l_white = "e5e5e5";
    # black_alt = "000000";

    theme = "Qogir-Custom-Dark";
    icon_theme = "Rowaita-Lavender-Dark";
    cursor_theme = "Simp1e-Adw-Dark";
    font = "MonaspiceAr Nerd Font Mono";
    # font = "0xProto Nerd Font Mono";
    emoji_font = "Noto Color Emoji";
    gowallTheme = pkgs.writeText "gowall-config.yml" ''
        themes:
          - name: "my-custom"
            colors:
              - "#${black}" 
              - "#${red}"  
              - "#${green}"  
              - "#${yellow}"  
              - "#${blue}"  
              - "#${magenta}"  
              - "#${cyan}" 
              - "#${white}"  
              - "#${l_black}" 
              - "#${l_red}"  
              - "#${l_green}"  
              - "#${l_yellow}"  
              - "#${l_blue}"  
              - "#${l_magenta}"  
              - "#${l_cyan}" 
              - "#${l_white}"'';

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
