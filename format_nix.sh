#!/bin/bash
nixfmt nixos/*.nix --indent=4
nixfmt nixos/home/*.nix --indent=4
nixfmt nixos/home/apps/*.nix --indent=4
nixfmt nixos/home/apps/bash/*.nix --indent=4
nixfmt nixos/home/apps/bspwm/*.nix --indent=4
nixfmt nixos/home/apps/conky/*.nix --indent=4
nixfmt nixos/home/apps/ghostty/*.nix --indent=4
nixfmt nixos/home/apps/gtk/*.nix --indent=4
nixfmt nixos/hosts/desktop/*.nix --indent=4
nixfmt nixos/hosts/laptop/*.nix --indent=4
nixfmt nixos/modules/*.nix --indent=4
