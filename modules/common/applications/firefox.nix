{ config, pkgs, lib, ... }: {

  options = {
    firefox = {
      enable = lib.mkEnableOption {
        description = "Enable Firefox.";
        default = false;
      };
    };
  };

  config = lib.mkIf
    (config.gui.enable && config.firefox.enable && pkgs.stdenv.isLinux) {

      home-manager.users.${config.user} = {

        programs.firefox = {

          enable = true;
          package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
            extraPolicies = {
              CaptivePortal = false;
              DisableFirefoxStudies = true;
              DisablePocket = true;
              DisableTelemetry = true;
              DisableFirefoxAccounts = false;
              NoDefaultBookmarks = true;
              OfferToSaveLogins = false;
              OfferToSaveLoginsDefault = false;
              PasswordManagerEnabled = false;
              FirefoxHome = {
                Search = true;
                Pocket = false;
                Snippets = false;
                TopSites = false;
                Highlights = false;
              };
              UserMessaging = {
                ExtensionRecommendations = false;
                SkipOnboarding = true;
              };
            };
          };
          profiles = {
            nixfox = {
              id = 0;
              name = "nixfox";
              extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                ublock-origin
                ghostery
                privacy-badger
                clearurls
                bitwarden
                vimium
                tree-style-tab
              ];
              search = {
                force = true;
                default = "Google";
                engines = {
                  "Nix Packages" = {
                    urls = [{
                      template = "https://search.nixos.org/packages";
                      params = [
                        {
                          name = "type";
                          value = "packages";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }];
                    icon =
                      "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                    definedAliases = [ "@np" ];
                  };
                  "NixOS Wiki" = {
                    urls = [{
                      template =
                        "https://nixos.wiki/index.php?search={searchTerms}";
                    }];
                    iconUpdateURL = "https://nixos.wiki/favicon.png";
                    updateInterval = 24 * 60 * 60 * 1000;
                    definedAliases = [ "@nw" ];
                  };
                  "Google".metaData.hidden = false;
                  "Amazon.com".metaData.hidden = true;
                  "Bing".metaData.hidden = true;
                  "eBay".metaData.hidden = true;
                };
              };
              settings = { "general.smoothScroll" = true; };
              extraConfig = ''
                user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
              '';
              userChrome = ''
                # css
                /* hides the native tabs */
                #TabsToolbar {
                  visibility: collapse;
                }
                /* hides the titlebar */
                #titlebar {
                  visibility: collapse;
                }
                /* hides the sidebar header */
                #sidebar-header {
                  visibility: collapse !important;
                }
              '';
              userContent = ''
                # Here too
              '';
            };
          };

        };

      };

    };

}
