#!/bin/bash
nixfmt nixos/configuration.nix --indent=4
nixfmt nixos/configuration_laptop.nix --indent=4
nixfmt nixos/home/home.nix --indent=4
nixfmt nixos/home/home_laptop.nix --indent=4
nixfmt nixos/home/home_links.nix --indent=4
nixfmt nixos/home/home_shared.nix --indent=4
nixfmt nixos/modules/commonpkgs.nix --indent=4
nixfmt nixos/modules/rowaita.nix --indent=4
nixfmt nixos/modules/settings.nix --indent=4
