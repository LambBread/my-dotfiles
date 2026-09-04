{
    pkgs,
    inputs,
    lib,
    ...
}:
{
    programs.librewolf = {
        enable = true;
        policies = {
            ExtensionSettings = {
                "graffiti-bold-colorway@mozilla.org" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/file/4066272/graffiti_bold-2.1.xpi";
                    installation_mode = "force_installed";
                    private_browsing = true;
                };
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
