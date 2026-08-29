{config, pkgs, ...}:
{
    home.activation.configureThunar = ''
        ${pkgs.xfconf}/bin/xfconf-query --channel thunar --property /last-show-hidden --create --type bool --set true
        ${pkgs.xfconf}/bin/xfconf-query --channel thunar --property /last-icon-view-zoom-level --create --type string --set THUNAR_ZOOM_LEVEL_75_PERCENT
        ${pkgs.xfconf}/bin/xfconf-query --channel thunar --property /last-menubar-visible --create --type bool --set false
    '';
    xdg.configFile."Thunar/uca.xml".text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <actions>
          <action>
            <icon>utilities-terminal</icon>
            <name>Open Terminal Here</name>
            <submenu></submenu>
            <unique-id>1785700247397756-1</unique-id>
            <command>ghostty --working-directory=&quot;%d&quot;</command>
            <description>Open Ghostty in the current directory</description>
            <range>*</range>
            <patterns>*</patterns>
            <startup-notify/>
            <directories/>
          </action>
          <action>
            <icon>nvim</icon>
            <name>Open Neovim Here</name>
            <submenu></submenu>
            <unique-id>1785700247397770-2</unique-id>
            <command>ghostty --working-directory=&quot;%d&quot; --command=&quot;nvim &apos;%f&apos;&quot;</command>
            <description>Open Neovim in Ghostty</description>
            <range></range>
            <patterns>*</patterns>
            <directories/>
            <text-files/>
            <other-files/>
          </action>
        </actions>
    '';
}
