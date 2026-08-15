# My dotfiles

These are some of my dotfiles.

## Important keybinds

### BSPWM/SXHKD

`Hyper` is mapped to Caps Lock in this config.

- `Hyper + Q` - close program
- `Hyper + W` - LibreWolf
- `Hyper + E` - Thunar
- `Hyper + R` - reload sxhkd
- `Hyper + T` - Ghostty
- `Hyper + A` - open rofi (window)
- `Hyper + S` - open rofi (drun)
- `Hyper + D` - open clipboard history
- `Hyper + L` - lock screen
- `Hyper + Z,X,C` - left, right, middle click
- `Hyper + ,` - reload picom
- `Hyper + .` - reload polybar
- `Hyper + arrow keys` - move mouse (coarse)
- `Hyper + Ctrl + arrow keys` - move mouse (fine)
- `Hyper + Shift + arrow keys` - scroll mouse
- `Hyper + Shift + Z,X,C` - left, right, middle mouse down
- `Hyper + Ctrl + Z,X,C` - left, right, middle mouse up
- `Hyper + Alt + Q` - kill program
- `Hyper + Super + Q` - exit bspwm
- `Hyper + Super + R` - reload bspwm
- `Print` - screenshot
- `Super + M` - toggle monocle mode
- `Super + T` - tiled mode
- `Super + Shift + T` - pseudo-tiled
- `Super + S` - floating mode
- `Super + F` - fullscreen
- `Super + 1-9,0,hyphen,equals` - switch to workspace 1-12
- `Super + Shift + 1-9,0,hyphen,equals` - move window to workspace 1-12
- `Super + hjkl` - select window in that direction
- `Super + Shift + hjkl` - move window in that direction
- `Super + Ctrl + hjkl` - preselect node in that direction
- `Super + Alt + hjkl` - expand window in that direction
- `Super + Alt + Shift + hjkl` - shrink window in that direction
- `Super + arrow keys` - move floating window

### Neovim

- `Ctrl + S` - save file
- `F2` - toggle Neo-tree
- `,x` - exit buffer
- `,j` - switch split buffer
- `,h` - previous buffer
- `,l` - next buffer


## Installation (Non-NixOS)

1. Install:
    - git
    - neovim >= 0.12.0
    - fastfetch
    - tmux
    - bspwm
    - dunst
    - feh
    - picom
    - xsettingsd
    - polybar
    - diodon
    - redshift
    - conky
    - ghostty
    - thunar
    - [MonaspiceAr Nerd Font Mono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Monaspace.zip)
    - [Qogir theme](https://github.com/vinceliuice/Qogir-theme)
    - [Rowaita icon theme (my fork)](https://github.com/LambBread/Rowaita-icon-theme) 
    - alacritty (optional)
    - [cortile](https://github.com/leukipp/cortile) (optional, Xfce)
    - Proton VPN (optional; if not using it, use laptop polybar and bspwm config)
    - WhatPulse (optional; if not using it, use laptop bspwm config)


2. Clone this repo into `~/.dotfiles`.

3. Make symlinks from `~/.dotfiles` into `~/.config`.

4. Add this line to `/etc/apparmor.d/usr.bin.redshift`:

`owner @{HOME}/.dotfiles/redshift/redshift.conf r`

and run `sudo systemctl restart apparmor`.

5. (Xfce) Add Picom, Redshift, Conky, and `xmodmap ~/.Xmodmap` to autostart if not done so already.
Make Ghostty (or Alacritty) your default terminal. Restart the XFCE panel via `xfce4-panel -r`. 
Open Neovim and type `:Lazy install` to install plugins. If you are on bspwm, this step is not needed.

6. If desired, modify panel layout (Xfce), set a desktop wallpaper, etc.

7. Modify configuration if desired.

## Installation (NixOS)

1. Install Git and add home-manager as a Nix channel.

2. Clone this repo into `~/.dotfiles`.

3. Copy `/etc/nixos/hardware-configuration.nix` to `~/.dotfiles/nixos/`.

4. Make a file in `~/.dotfiles/nixos/` named `personal.nix`.

Example:

```nix
{
    SHORT_NAME = "name";
    LONG_NAME = "Full Name";
    DESK_NAME = "desktop";
    USERNAME = "MyGithubUsername";
    EMAIL = "my.email@example.com";
}
```

5. Symlink `~/.dotfiles/nixos/` to `/etc/nixos`.

6. Run `sudo nixos-rebuild switch`, or if on laptop, 
`sudo nixos-rebuild switch -Inixos-config=/etc/nixos/configuration_laptop.nix`.

7. If on desktop, setup SSH keys for GitHub named
`~/.ssh/gh_key` (signing) and `~/.ssh/gh_key2` (authentication).

8. Modify configuration if desired.

## Credits

The conky config was created by [AguilarLagunasAturo](https://github.com/AguilarLagunasArturo/conky-themes).
The rofi config was created by [Prayag2](https://github.com/Prayag2/dotfiles).
The fastfetch logos are derivative works, with the Debian logos being under the LGPLv3-or-later or CC-BY-SA 3.0 Unported,
and the Nix logos being under the CC-BY 4.0.
See [the README](./config/fastfetch/logos/README.md) for details.

The default wallpaper fetched in the NixOS config was made by Reddit user u/FaithlessnessDue2763, 
on their post ["Blue city"](https://www.reddit.com/r/VaporwaveAesthetics/comments/1t9j5ya/blue_city/).
