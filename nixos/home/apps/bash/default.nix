{
    config,
    pkgs,
    colors,
    personal,
    ...
}:
{
    imports = [
        ./fastfetch.nix
    ];
    home.file.".dircolors".source = ./.dircolors;
    home.file.".blerc".source = ./.blerc;
    # xdg.configFile."fastfetch" = {
    #     source = ./fastfetch;
    #     recursive = true;
    # };
    programs.bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
            ".." = "cd ..";
            "cdu" = "cd ..";
            "..." = "cd ../..";
            "cdp" = "cd -";
            "-" = "cd -";
            "vim" = "nvim";
            "py3" = "python3";
            "clear" = "reset";
            "ls" = "ls -a --color=auto";
            "grep" = "grep --color=auto";
            "sl" = "ls -a --color=auto";
            "fetch" = "hyfetch";
            "ffetch" = "fastfetch";
            #"fastfetch" = "printf '\\n' && fastfetch";
            "rm" = "rm -v";
            "cp" = "cp -v";
            "mv" = "mv -v";
            "btw" = "echo \"I use NixOS, Neovim, and bspwm btw\"";
            "nrs" = "sudo nixos-rebuild switch --flake /etc/nixos/#desktop";
            "nrsl" = "sudo nixos-rebuild switch --flake /etc/nixos/#laptop";
            "ncg" = "sudo nix-collect-garbage";
        };
        initExtra = ''
            eval "$(dircolors -b ~/.dircolors)"
            PS1='\[\033[00;94m\]\[\033[00;01;104m\] \u\
            \[\033[00;94;105m\]\[\033[00;01;105m\] \w \
            \[\033[00;95;45m\]\[\033[35;48;2;${colors.hexToRgbStr "#${colors.m_magenta}" ";"}m\]\
            \[\033[38;2;${colors.hexToRgbStr "#${colors.m_magenta}" ";"};40m\]\
            \[\033[30;48;2;${colors.hexToRgbStr "#${colors.black_alt}" ";"}m\]\
            \[\033[38;2;${colors.hexToRgbStr "#${colors.black_alt}" ";"};106m\]\
            \[\033[00;01;03;106;30m\]  \A\[\033[00;96m\] \[\033[00m\] '

            if [[ $- == *i* ]]; then
                source ${pkgs.blesh}/share/blesh/ble.sh
            fi
        '';
    };

    programs.tmux = {
        enable = true;
        terminal = "xterm-256color";
        escapeTime = 0;
        mouse = true;
        prefix = "C-a";
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
