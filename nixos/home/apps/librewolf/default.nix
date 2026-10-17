{
    pkgs,
    inputs,
    lib,
    colors,
    ...
}:
{
    programs.librewolf = {
        enable = true;
        policies = {
            ExtensionSettings = {
                # "graffiti-bold-colorway@mozilla.org" = {
                #     install_url = "https://addons.mozilla.org/firefox/downloads/file/4066272/graffiti_bold-2.1.xpi";
                #     installation_mode = "force_installed";
                #     private_browsing = true;
                # };
                "{4c421bb7-c1de-4dc6-80c7-ce8625e34d24}" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/file/4769138/load_reddit_images_directly-1.9.xpi";
                    installation_mode = "force_installed";
                    private_browsing = true;
                };
                "helloyanis@ageverif-bypass" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/file/4995911/age_verification_bypass-1.2.1.xpi";
                    installation_mode = "force_installed";
                    private_browsing = true;
                };
                "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/file/4779333/hide_youtube_shorts-1.11.0.xpi";
                    installation_mode = "force_installed";
                    private_browsing = true;
                };

            };
        };
        profiles.default = {
            id = 0;
            name = "default";
            isDefault = true;

            userChrome = builtins.replaceStrings [ "412853" ] [ "${colors.black}" ] (
                builtins.readFile ./userChrome.css
            );

            userContent =
                builtins.replaceStrings
                    [
                        "9768b6"
                        "412853"
                        "MonaspiceAr Nerd Font Mono"
                        "0c1315"
                        "ece3d5"
                        "cfb793"
                        "bc9ed0"
                        "d07271"
                        "16px"
                        "6ba1db"
                        "9fd356"
                        "e0de4b"
                        "9768b5"
                    ]
                    [
                        "${colors.magenta}"
                        "${colors.black}"
                        "${colors.font}"
                        "${colors.black_alt}"
                        "${colors.l_white}"
                        "${colors.white}"
                        "${colors.l_magenta}"
                        "${colors.l_red}"
                        "${builtins.toString colors.corner_radius}"
                        "${colors.l_blue}"
                        "${colors.l_green}"
                        "${colors.l_yellow}"
                        "${colors.m_magenta}"
                    ]
                    (builtins.readFile ./userContent.css);

            settings = {
                "extensions.autoDisableScopes" = 0;
                "privacy.resistFingerprinting" = false;
                "privacy.fingerprintingProtection" = true;
                "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";
                "privacy.sanitize.sanitizeOnShutdown" = false;
                "webgl.disabled" = false;
                "layers.acceleration.disabled" = false;
                "gfx.webrender.all" = true;
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                "browser.toolbars.bookmarks.visibility" = "always";
                "browser.bookmarks.showOtherBookmarks" = true;
                "devtools.debugger.remote-enabled" = true;
                "devtools.chrome.enabled" = true;
            };

            extensions = {
                packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
                    ublock-origin
                    bitwarden
                    darkreader
                    sponsorblock
                    dearrow
                    return-youtube-dislikes
                    ghostery
                    indie-wiki-buddy
                ];
            };
        };
    };
}
