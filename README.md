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


## Installation (NixOS)

1. Install Git and enable flakes in your existing configuration.

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
    LOCATION =
    {
        lat = "50";
        lon = "-120";
    };
    WEATHER_LINK = "https://weather.com";
    MONITORS = [
        "DP-5" "HDMI-0"
    ]; # only required for desktops
}
```

5. Delete or move `/etc/nixos` and symlink `~/.dotfiles/nixos/` to `/etc/nixos`.

6. If on desktop, modify any user-specific details such as the default of
NVIDIA drivers with a multi-monitor setup.

7. Add `personal.nix` and `hardware-configuration.nix` to Git using `--intent-to-add`.

```bash
git add -N -f nixos/personal.nix
git add -N -f nixos/hardware-configuration.nix
git update-index --skip-worktree nixos/personal.nix
git update-index --skip-worktree nixos/hardware-configuration.nix
```

8. Run `sudo nixos-rebuild switch --flake /etc/nixos/#desktop`, or if on laptop, 
`sudo nixos-rebuild switch --flake /etc/nixos/#laptop`.

9. If on desktop, setup SSH keys for GitHub named
`~/.ssh/gh_key` (signing) and `~/.ssh/gh_key2` (authentication).

10. Modify configuration if desired.

## Credits

- The conky config was created by [AguilarLagunasAturo](https://github.com/AguilarLagunasArturo/conky-themes).
- The rofi config was created by [Prayag2](https://github.com/Prayag2/dotfiles).
- The ghostty shaders were created by 
  [sahaj-b](https://github.com/sahaj-b/ghostty-cursor-shaders) (MIT license) and 
  [qwerasd205](https://github.com/0xhckr/ghostty-shaders/blob/main/bloom.glsl).

The fastfetch logos are derivative works under the CC-BY 4.0. 
See [the README](./nixos/home/config/fastfetch/logos/README.md) for details.

The default wallpaper fetched in the NixOS config was made by Reddit user u/FaithlessnessDue2763, 
on their post ["Blue city"](https://www.reddit.com/r/VaporwaveAesthetics/comments/1t9j5ya/blue_city/).
