{
    pkgs,
    inputs,
    lib,
    ...
}:
let
    colors = import ../../modules/colors.nix { inherit pkgs; };
in
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

            userChrome = ''
                #TabsToolbar
                {
                    visibility: collapse !important;
                }

                .titlebar-buttonbox-container
                {
                    display: none !important;
                }

                #urlbar-background
                {
                    background-color: #${colors.black} !important;
                }

                .tab-text
                {
                    font-size: 14px !important;
                    font-weight: bold !important;
                }

                #PersonalToolbar
                {
                    --uc-bm-height: 24px;
                    max-height: 0px !important;
                    min-height: 0px !important;
                    padding-block: 0px !important;
                    opacity: 0 !important;
                    transition: opacity 0.15s ease, max-height 0.15s ease !important;
                }

                #navigator-toolbox:hover #PersonalToolbar
                {
                    max-height: var(--uc-bm-height) !important;
                    opacity: 1 !important;
                }
            '';

            userContent = ''
                /*
                body
                {
                    background-color: #${colors.black} !important;
                }*/

                @-moz-document url("about:newtab"), url("about:home")
                {
                    .search-wrapper, #newtab-search-container, .search-inner-wrapper
                    {
                        display: none !important;
                    }

                    body
                    {
                        background-color: #${colors.black} !important;
                    }
                }

                @-moz-document url-prefix("https://discord.com")
                {
                    #app-mount, .theme-dark, .theme-light
                    {
                        --font-primary: "${colors.font}" !important;
                        --font-display: "${colors.font}" !important;
                    }
                }

                :root
                {
                    --theme-code-font-size: 14px !important;
                    --theme-body-font-size: 13px !important;
                    --theme-highlight-keyword: #${colors.l_magenta} !important;
                    --theme-highlight-blue: #${colors.l_blue} !important;
                    --theme-highlight-green: #${colors.l_green} !important;
                    --theme-highlight-red: #${colors.l_red} !important;
                    --theme-highlight-purple: #${colors.l_magenta} !important;
                    --console-warning-color: #${colors.l_yellow} !important;
                    --console-error-color: #${colors.red} !important;
                    --theme-icon-warning-color: #${colors.l_yellow} !important;
                    --theme-icon-error-color: #${colors.red} !important;
                    --theme-body-background: #${colors.black} !important;
                    --theme-selection-background: #${colors.magenta} !important;
                    --theme-toolbar-background: #${colors.black} !important;
                    --theme-background: #${colors.magenta} !important;
                    --theme-tab-toolbar-background #${colors.black} !important;
                    --theme-sidebar-background: #${colors.black} !important;
                    --theme-comment: #${colors.magenta} !important;
                }

                .devtools-monospace,
                .CodeMirror,
                .prism
                {
                    font-family: "${colors.font}", monospace !important;
                }

            '';

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
