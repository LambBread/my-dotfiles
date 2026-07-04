# My dotfiles

These are some of my dotfiles.

## Important keybinds

### BSPWM/SXHKD

`Hyper + T` - Ghostty
`Hyper + E` - Thunar
`Hyper + W` - LibreWolf
`Hyper + L` - lock screen
`Hyper + Q` - close program
`Hyper + Alt + Q` - kill program
`Hyper + Super + Q` - exit bspwm
`Hyper + Super + R` - reload bspwm
`Hyper + R` - reload sxhkd
`Print` - screenshot
`Super + M` - toggle monocle mode
`Super + T` - tiled mode
`Super + Shift + T` - pseudo-tiled
`Super + S` - floating mode
`Super + F` - fullscreen
`Super + 1-9,0,hyphen,equals` - switch to workspace 1-12
`Super + Shift + 1-9,0,hyphen,equals` - move window to workspace 1-12
`Super + hjkl` - select window in that direction
`Super + Shift + hjkl` - move window in that direction
`Super + Ctrl + hjkl` - preselect node in that direction
`Super + Alt + hjkl` - expand window in that direction
`Super + Alt + Shift + hjkl` - shrink window in that direction

### Neovim

`Ctrl + S` - save file
`F2` - toggle Neo-tree
`,x` - exit buffer
`,j` - switch split buffer
`,h` - previous buffer
`,l` - next buffer


## Installation

*Note: The .bashrc assumes you have Emscripten installed to `/opt/emsdk/` and have a Python venv in `~/.venv/`,
so you may want to modify it if you are not. The redshift.conf also assumes your location is Prince George, BC, 
so you should modify it for your location.*

1. Install:
    - Git
    - Neovim >= 0.9.4
    - bspwm
    - xsettingsd
    - [MonaspiceAr Nerd Font Mono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Monaspace.zip)
    - Conky
    - Picom
    - Alacritty
    - Ghostty
    - Redshift
    - Fastfetch
    - Tmux
    - [Cortile](https://github.com/leukipp/cortile)

It is also expected you have XFCE installed.

2. Clone this repo into `~/.dotfiles`.

3. Run `install.sh` after making it executable. If you want a laptop configuration,
   run `install.sh laptop`.

4. Add this line to `/etc/apparmor.d/usr.bin.redshift`:

`owner @{HOME}/.dotfiles/redshift/redshift.conf r`

and run `sudo systemctl restart apparmor`.

5. (Xfce) Add Picom, Redshift, Conky, and `xmodmap ~/.Xmodmap` to autostart if not done so already.
Make Ghostty (or Alacritty) your default terminal. Restart the XFCE panel via `xfce4-panel -r`. 
Open Neovim and type `:Lazy install` to install plugins. If you are on bspwm, this step is not needed.

6. If desired, modify panel layout, set a desktop wallpaper, 
change GTK/xfwm theme ([Qogir](https://github.com/vinceliuice/Qogir-theme) recommended), 
change icons/cursors ([Rowaita](https://github.com/4e6anenk0/Rowaita-icon-theme) icons recommended), etc.

7. Modify configuration if desired.

## Credits

The conky config was created by [AguilarLagunasAturo](https://github.com/AguilarLagunasArturo/conky-themes).
The fastfetch logos are derivative works and are under the LGPLv3-or-later or CC-BY-SA 3.0 Unported. 
See [the README](./fastfetch/logos/README.md) for details.
