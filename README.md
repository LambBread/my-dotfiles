# My dotfiles

These are some of my dotfiles for gtk-3.0, picom, and redshift. It also gets [a neovim config](https://github.com/LambBread/my-nvim-config) and [a conky config](https://github.com/LambBread/conky-themes).

## Installation

1. Install Git, Neovim >= 0.9.0, a nerd font, Conky, Picom, and Redshift. It is also expected you are using XFCE.

2. Clone this repo into an easy-to-remember directory, such as `~/.dotfiles`.

3. Run `get_dots.sh` to acquire the [neovim config](https://github.com/LambBread/my-nvim-config) and the [conky config](https://github.com/LambBread/conky-themes).


4. Make symbolic links in `~/.config` going to this directory. The symlinks you need are:

    - `~/.config/nvim/` -> `~/.dotfiles/nvim/`
    - `~/.config/conky/` -> `~/.dotfiles/conky/`
    - `~/.config/gtk-3.0/` -> `~/.dotfiles/gtk-3.0/`
    - `~/.config/picom/` -> `~/.dotfiles/picom/`
    - `~/.config/redshift.conf` -> `~/.dotfiles/redshift.conf`

5. Add Picom, Redshift, and Conky to autostart if not done so already. Restart the XFCE panel via `xfce4-panel -r`. Open Neovim and type `:PlugInstall` to install plugins.

6. If desired, modify panel layout, set a desktop wallpaper, change GTK/xfwm theme, change icons/cursors, etc.

7. Modify configuration if desired.
