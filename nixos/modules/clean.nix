{
    pkgs,
    config,
    personal,
    ...
}:
{
    systemd.services.bleachbit-daily = {
        description = "Run BleachBit daily on both the root and user level";
        path = [
            pkgs.su
            pkgs.coreutils
            pkgs.systemd
            pkgs.glibc
        ];
        serviceConfig = {
            Type = "oneshot";
            User = "root";
            Environment = "HOME=/root DISPLAY=:0 LC_ALL=en_CA.UTF-8";
        };
        script = ''
            ${pkgs.bleachbit}/bin/bleachbit --clean journald.clean deepscan.tmp system.cache system.rotated_logs bash.history bash.tmp
                
            cleaned_user="bash.history bash.tmp chromium.cache chromium.cookies chromium.dom chromium.form_history chromium.history chromium.passwords chromium.search_engines chromium.session chromium.site_preferences chromium.sync chromium.vacuum deepscan.backup deepscan.ds_store deepscan.thumbs_db deepscan.tmp deepscan.vim_swap_user discord.cache discord.cookies discord.history discord.vacuum journald.clean librewolf.backup librewolf.cache librewolf.crash_reports librewolf.passwords librewolf.url_history librewolf.vacuum system.clipboard system.recent_documents system.rotated_logs system.tmp system.trash thumbnails.cache vlc.memory_dump vlc.mru x11.debug_logs"

            su -l ${personal.SHORT_NAME} -c "LC_ALL=en_CA.UTF-8 ${pkgs.bleachbit}/bin/bleachbit --clean ''${cleaned_user}"
        '';
    };

    systemd.services.luckybackup-daily = {
        description = "Run luckyBackup daily";
        path = [
            pkgs.rsync
            pkgs.gnugrep
            pkgs.gnused
            pkgs.coreutils
        ];
        serviceConfig = {
            Type = "oneshot";
            User = "root";
            Environment = "HOME=/root DISPLAY=:0 XAUTHORITY=/root/.Xauthority LC_ALL=en_CA.UTF-8";
        };
        script = ''
            ${pkgs.luckybackup}/bin/luckybackup -c --no-questions --silent /root/.luckyBackup/profiles/default.profile
        '';
    };

    systemd.timers.bleachbit-daily = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
            OnCalendar = "*-*-* 03:30:00";
            Persistent = true;
        };
    };

    systemd.timers.luckybackup-daily = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
            OnCalendar = "*-*-* 04:00:00";
            Persistent = false;
        };
    };

    nix.gc = {
        automatic = true;
        dates = "02:00";
        options = "--delete-older-than 7d";
    };

    nix.optimise = {
        automatic = true;
        dates = "03:00";
    };
}
