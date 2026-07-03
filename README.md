# My dotfiles

These are some of my dotfiles for GTK, Picom, Alacritty, Fastfetch, Ghostty, Bash, [Cortile](https://github.com/leukipp/cortile),
Redshift, Conky, Neovim, and Tmux. 

## Installation

*Note: The .bashrc assumes you have Emscripten installed to `/opt/emsdk/` and have a Python venv in `~/.venv/`,
so you may want to modify it if you are not. The redshift.conf also assumes your location is Prince George, BC, 
so you should modify it for your location.*

1. Install:
    - Git
    - Neovim >= 0.9.4
    - [MonaspiceAr Nerd Font Mono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Monaspace.zip)
    - Conky
    - Picom
    - Alacritty
    - Ghostty
    - Redshift
    - Fastfetch
    - Tmux
    - [Cortile](https://github.com/leukipp/cortile)

It is also expected you are using XFCE.

2. Clone this repo into `~/.dotfiles`.

3. Run `install.sh` after making it executable. If you want a laptop configuration,
   run `install.sh laptop`.

4. Add this line to `/etc/apparmor.d/usr.bin.redshift`:

`owner @{HOME}/.dotfiles/redshift/redshift.conf r`

and run `sudo systemctl restart apparmor`.

5. Add Picom, Redshift, Conky, and `xmodmap ~/.Xmodmap` to autostart if not done so already.
Make Ghostty (or Alacritty) your default terminal. Restart the XFCE panel via `xfce4-panel -r`. 
Open Neovim and type `:Lazy install` to install plugins.

6. If desired, modify panel layout, set a desktop wallpaper, 
change GTK/xfwm theme ([Qogir](https://github.com/vinceliuice/Qogir-theme) recommended), 
change icons/cursors ([Rowaita](https://github.com/4e6anenk0/Rowaita-icon-theme) icons recommended), etc.

7. Modify configuration if desired.

## Credits

The conky config was created by [AguilarLagunasAturo](https://github.com/AguilarLagunasArturo/conky-themes).
The fastfetch logos are derivative works and are under the LGPLv3-or-later or CC-BY-SA 3.0 Unported. 
See [the README](./fastfetch/logos/README.md) for details.
