#!/bin/bash
nixfmt nixos/*.nix --indent=4
nixfmt nixos/home/*.nix --indent=4
nixfmt nixos/home/config/*.nix --indent=4
nixfmt nixos/modules/*.nix --indent=4
