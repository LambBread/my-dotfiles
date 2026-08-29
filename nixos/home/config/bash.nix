{ config, pkgs, ... }:
let
    colors = import ../../modules/colors.nix;
    personal = import ../../personal.nix;
in
{
    home.file.".dircolors".source = ./.dircolors;
    programs.bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
            "cdu" = "cd ..";
            "cdp" = "cd -";
            "vim" = "nvim";
            "py3" = "python3";
            "clear" = "reset";
            "ls" = "ls -a --color=auto";
            "grep" = "grep --color=auto";
            "sl" = "ls -a --color=auto";
            "fastfetch" = "printf '\\n' && fastfetch";
            "rm" = "rm -v";
            "cp" = "cp -v";
            "mv" = "mv -v";
            "btw" = "echo \"I use $(. /etc/os-release; echo $NAME), Neovim, and bspwm btw\"";
            "nrs" = "sudo nixos-rebuild switch";
            "nrsl" = "sudo nixos-rebuild switch -Inixos-config=/etc/nixos/configuration_laptop.nix";
            "ncg" = "sudo nix-collect-garbage";
        };
        initExtra = ''
            eval "$(dircolors -b ~/.dircolors)"
            PS1='\[\033[00;95m\]\[\033[00;01;105m\] \u\[\033[00;95;44m\]\[\033[00;01;44m\] \w \[\033[00;34;47m\]\[\033[37;102m\]\[\033[92;101m\]\[\033[91;41m\]\[\033[00;01;41m\]  \A\[\033[00;31m\] \[\033[00m\] '
        '';
    };

    programs.tmux = {
        enable = true;
        terminal = "xterm-256color";
        escapeTime = 0;
        mouse = true;
        prefix = "<C-a>";
        baseIndex = 0;
        extraConfig = ''
            set -as terminal-overrides ",xterm*:colors=256"
            set -ag terminal-overrides ",xterm*:Tc"
            set -as terminal-features ",xterm*:RGB"
            set -g allow-passthrough on
            set -g status-style "bg=#${colors.blue}"
            set -g message-style "fg=black bg=#${colors.l_magenta}"
            set -g default-command "''${SHELL}"
            bind | split-window -h
            bind - split-window -v
            bind r source-file ~/.config/tmux/tmux.conf
            unbind %
            unbind '"'
        '';
    };
}
