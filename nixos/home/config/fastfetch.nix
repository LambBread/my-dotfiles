{
    config,
    lib,
    pkgs,
    ...
}:
let
    personal = import ../../personal.nix;
    colors = import ../../modules/colors.nix { inherit pkgs; };
    fastfetch_logos = {
        nix = ./fastfetch/logos/nix.png;
        nix_bi = ./fastfetch/logos/nix_bi.png;
        nix_pan = ./fastfetch/logos/nix_pan.png;
        nix_trans = ./fastfetch/logos/nix_trans.png;
    };
    processed_logos =
        pkgs.runCommand "processed-logos"
            {
                nativeBuildInputs = [ pkgs.gowall ];
            }
            ''
                mkdir -p $out
                export HOME=$NIX_BUILD_TOP
                mkdir -p $HOME/.config/gowall
                cp ${colors.gowallTheme} $HOME/.config/gowall/config.yml

                ${lib.concatStringsSep "\n" (
                    lib.mapAttrsToList (name: path: ''
                        gowall convert ${path} --output $out/${name}.png -t my-custom --preview false
                    '') fastfetch_logos
                )}
            '';

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
              }
          },
          "logo": {
                "type": "auto",
                "source": "~/.config/fastfetch/logos/nix_trans.png",
                "color": {
                    "1": "94",
                    "2": "96",
                    "3": "94",
                    "4": "96",
                    "5": "94",
                    "6": "96"
                }
          },
          "modules": [
              {
                  "type": "custom",
                  "key": "{#95}{#0}{#105}{#30}{#1}        SYSTEM         {#0}{#95}"
              },
            "break",
            {
                "type": "os",
                "key": " OS"
            },
            {
                "type": "host",
                "key": " Host"
            },
            {
                "type": "kernel",
                "key": " Kernel"
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
                "key": " Shell"
            },
            {
                "type": "localip",
                "key": " Local IP"
            },
            
            "break",
            {
                "type": "custom",
                "key": "{#92}{#0}{#102}{#30}{#1}         MISC          {#0}{#92}"
            },
            "break",

            {
                "type": "uptime",
                "key": "󰥔 Uptime",
                "keyColor": "92"
            },
            {
                "type": "command",
                "key": " OS Birthday",
                "keyColor": "92",
                "text": "date -d @$(stat -c %W /) '+%d %B %Y'"
            },
            {
                "type": "command",
                "key": "󰖕 Weather",
                "keyColor": "92",
                "text": "curl 'https://wttr.in/${personal.LOCATION.lat},${personal.LOCATION.lon}?format=%C%20%t&m'"
            },

            "break",
              {
                  "type": "custom",
                  "key": "{#37}{#0}{#47}{#30}{#1}       HARDWARE        {#0}{#37}"
              },
              "break",
            
            {
                "type": "battery",
                "key": " Battery",
                "keyColor": "white"
            },
            {
                "type": "memory",
                "key": " RAM",
                "keyColor": "white"
            },
            {
                "type": "swap",
                "key": " Swap",
                "keyColor": "white"
            },
            {
                "type": "disk",
                "key": "󰋊 Disk ({mountpoint})",
                "keyColor": "white"
            },
            {
                "type": "cpu",
                "key": " CPU",
                "keyColor": "white"
            },
            {
                "type": "gpu",
                "key": " GPU",
                "keyColor": "white"
            },
            {
                "type": "display",
                "key": "󰍹 Display ({name})",
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
                "key": " DE",
                "keyColor": "94"
            },
            {
                "type": "wm",
                "key": "󱂬 WM",
                "keyColor": "94"
            },
            {
                "type": "wmtheme",
                "key": " WM Theme",
                "keyColor": "94"
            },
            {
                "type": "theme",
                "key": " Theme",
                "keyColor": "94"
            },
            {
                "type": "icons",
                "key": " Icons",
                "keyColor": "94"
            },
            {
                "type": "cursor",
                "key": " Cursor",
                "keyColor": "94"
            },
            {
                "type": "font",
                "key": " Font",
                "keyColor": "94"
            },
            {
                "type": "terminalfont",
                "key": " Terminal Font",
                "keyColor": "94"
            },
            
            "break",
            
            {
                "type": "custom",
                "key": "{#30} {#31} {#32} {#33} {#34} {#35} {#36} {#37}"
            },
            { 
                "type": "custom",
                "key": "{#90} {#91} {#92} {#93} {#94} {#95} {#96} {#97}"
            }
          ]
        }
    '';

    xdg.configFile."fastfetch/logos".source = processed_logos;
    #xdg.configFile."fastfetch/logos/nix.png".text = processed_logos.nix_png;
    #xdg.configFile."fastfetch/logos/nix_bi.png".text = processed_logos.nix_bi_png;
    #xdg.configFile."fastfetch/logos/nix_pan.png".text = processed_logos.nix_pan_png;
    #xdg.configFile."fastfetch/logos/nix_trans.png".text = processed_logos.nix_trans_png;

    #    source = ./fastfetch/logos;
    #    recursive = true;
    #};
}
