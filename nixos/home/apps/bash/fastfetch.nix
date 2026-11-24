{
    config,
    lib,
    pkgs,
    colors,
    personal,
    ...
}:
let
    # fastfetch_logos = {
    #     nix = ./fastfetch/logos/nix.png;
    #     nix_bi = ./fastfetch/logos/nix_bi.png;
    #     nix_pan = ./fastfetch/logos/nix_pan.png;
    #     nix_trans = ./fastfetch/logos/nix_trans.png;
    # };
    # processed_logos =
    #     pkgs.runCommand "processed-logos"
    #         {
    #             nativeBuildInputs = [ pkgs.gowall ];
    #         }
    #         ''
    #             mkdir -p $out
    #             export HOME=$NIX_BUILD_TOP
    #             mkdir -p $HOME/.config/gowall
    #             cp ${colors.gowallTheme} $HOME/.config/gowall/config.yml

    #             ${lib.concatStringsSep "\n" (
    #                 lib.mapAttrsToList (name: path: ''
    #                     gowall convert ${path} --output $out/${name}.png -t my-custom --preview false
    #                 '') fastfetch_logos
    #             )}
    #         '';

in
{
    xdg.configFile."fastfetch/presets/default.jsonc".text = ''
        {
          "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
          "modules": [
            "title",
            "separator",
            "os",
            "host",
            "kernel",
            "uptime",
            "packages",
            "shell",
            "display",
            "de",
            "wm",
            "wmtheme",
            "theme",
            "icons",
            "font",
            "cursor",
            "terminal",
            "terminalfont",
            "cpu",
            "gpu",
            "memory",
            "swap",
            "disk",
            "localip",
            "battery",
            "poweradapter",
            "locale",
            "break",
            "colors"
          ]
        }
    '';

    xdg.configFile."fastfetch/config.jsonc".text = ''
        {
          "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
          "display": {
              "separator": " ",
              "color":
              {
                    "keys": "95",
                    "title": "95"
              },
              "disableLinewrap": true
          },
          // "logo": {
          //       "type": "auto",
          //       "source": "~/.config/fastfetch/logos/nix_trans.png",
          //       "color": {
          //           "1": "94",
          //           "2": "96",
          //           "3": "94",
          //           "4": "96",
          //           "5": "94",
          //           "6": "96"
          //       }
          // },
          "modules": [
              {
                  "type": "custom",
                  "key": "{#95}{#0}{#105}{#30}{#1}        SYSTEM         {#0}{#95}"
              },
            "break",
            {
                "type": "os",
                "key": " OS      "
            },
            {
                "type": "host",
                "key": " Host    "
            },
            {
                "type": "kernel",
                "key": " Kernel  "
            },
            {
                "type": "packages",
                "key": "󰆧 Packages",
                "combined": true
            },
            {
                "type": "terminal",
                "key": " Terminal"
            },
            {
                "type": "shell",
                "key": " Shell   "
            },
            {
                "type": "uptime",
                "key": "󰥔 Uptime  ",
            },
            

            "break",
              {
                  "type": "custom",
                  "key": "{#37}{#0}{#47}{#30}{#1}       HARDWARE        {#0}{#37}"
              },
              "break",
            
            {
                "type": "battery",
                "key": " Battery ",
                "keyColor": "white"
            },
            {
                "type": "memory",
                "key": " RAM     ",
                "percent":
                {
                    "type": ["num", "bar"]
                },
                "format": "{percentage-bar}",
                "keyColor": "white"
            },
            {
                "type": "swap",
                "key": " Swap    ",
                "percent":
                {
                    "type": ["num", "bar"]
                },
                "format": "{percentage-bar}",
                "keyColor": "white"
            },
            {
                "type": "disk",
                "key": "󰋊 Disk    ",
                "percent": {
                    "type": ["num", "bar"]
                },
                "format": "{size-percentage-bar} {mountpoint} ({filesystem})",
                "keyColor": "white"
            },
            {
                "type": "cpu",
                "key": " CPU     ",
                "keyColor": "white"
            },
            {
                "type": "gpu",
                "key": " GPU     ",
                "format": "{name}",
                "keyColor": "white"
            },
            {
                "type": "display",
                "key": "󰍹 Display ",
                "format": "{name} {width}x{height} @ {refresh-rate}Hz",
                "keyColor": "white"
            },

            "break",
            
              {
                  "type": "custom",
                  "key": "{#94}{#0}{#104}{#30}{#1}        THEME          {#0}{#94}"
              },
              "break",
            {
                "type": "de",
                "key": " DE      ",
                "keyColor": "94"
            },
            {
                "type": "wm",
                "key": "󱂬 WM      ",
                "keyColor": "94"
            },
            {
                "type": "theme",
                "key": " Theme   ",
                "keyColor": "94"
            },
            {
                "type": "icons",
                "key": " Icons   ",
                "keyColor": "94"
            },
            
            "break",
            
            {
                "type": "custom",
                "key": "{#38;2;${colors.hexToRgbStr "#${colors.black_alt}" ";"}} {#30} {#38;2;${colors.hexToRgbStr "#${colors.m_magenta}" ";"}} {#35} {#95} {#38;2;${colors.hexToRgbStr "#${colors.pink}" ";"}} {#38;2;${colors.hexToRgbStr "#${colors.l_pink}" ";"}}"
            },
            {
                "type": "custom",
                "key": "{#31} {#32} {#33} {#34} {#36} {#37} {#38;2;${colors.hexToRgbStr "#${colors.m_white}" ";"}}"
            },
            {
                "type": "custom",
                "key": "{#91} {#92} {#93} {#94} {#96} {#97} {#90}"
            }
            //{
            //    "type": "custom",
            //    "key": "{#38;2;${colors.hexToRgbStr "#${colors.black_alt}" ";"}}"
            //}
          ]
        }
    '';

    xdg.configFile."hyfetch.json".text = ''
        {
            "preset": "transgender",
            "mode": "rgb",
            "auto_detect_light_dark": true,
            "light_dark": "dark",
            "lightness": 0.65,
            "color_align": {
                "mode": "horizontal"
            },
            "backend": "fastfetch",
            "args": null,
            "distro": null,
            "pride_month_disable": false,
            "custom_ascii_path": null,
            "custom_presets": null,
            "palette_glyph": null,
            "palette_type": null
        }

    '';

    # xdg.configFile."fastfetch/logos".source = ./fastfetch/logos;
}
