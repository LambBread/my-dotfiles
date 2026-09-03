{ config, pkgs, ... }:
let
    colors = import ../../modules/colors.nix { inherit pkgs; };
in
{
    xdg.configFile."rofi/config.rasi".text = ''
            
        configuration {
        		show-icons: true;
        		modi: "drun,window";
        		show: "drun";
                font: "${colors.font}";
                icon-theme: "${colors.icon_theme}";
                drun {
                    fallback-icon: "package-x-generic";
                }
        }

        configuration {
            font: "${colors.font} 12";
            line-margin: 10;

            display-ssh:    "";
            display-run:    "";
            display-drun:   "";
            display-window: "";
            display-combi:  "";
            display-emoji: "ﲃ";
            display-calc: "";
            display-clipboard: "󰅍";
            fixed-num-lines: false;
            show-icons:     true;
            transparency: "real";
        }

        // THEME
        * {
            vertical-align: 0.5;
            
            // Colors
            bg: #${colors.black}90;
            fg: #${colors.l_white};
            selection: #${colors.magenta}c0;
            transparent: #00000000;
        }
        window {
            border: 2px;
            border-radius: 20;
            border-color: @fg;
        }
        window {
            background-color: @bg;
        }
        mainbox,inputbar,listview,message,textbox,prompt,entry{
            background-color: @transparent;
        }

        // Inputbar
        inputbar {
            padding: 2px;
            children: [prompt,entry];
        }
        prompt {
            font: "monospace 22";
            padding: 0 16px 0 8px;
            color: @fg;
        }
        entry {
            color: @fg;
        }

        // Element
        listview {
            border: none;
            scrollbar: false;
        }
        element, message {
            padding: 3px;
        }
        element selected.normal, element normal.active, element selected.active {
            background-color: @selection;
        }
        element normal.normal, element alternate.normal, scrollbar {
            background-color: @transparent;
        }
        element-icon, element-text {
            background-color: @transparent;
            color: @fg;
        }
        element-icon {
            padding: 0 8px 0 0;
        }
        scrollbar {
            handle-color: @fg;
        }

        // Message
        message {
            border: none;
        }
        textbox {
            color: @fg;
        }
    '';
}
