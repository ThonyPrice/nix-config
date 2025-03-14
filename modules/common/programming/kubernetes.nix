{ config, pkgs, lib, ... }: {

  options.kubernetes.enable = lib.mkEnableOption "Kubernetes tools.";

  config = lib.mkIf config.kubernetes.enable {
    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        kubectl # Basic Kubernetes queries
        kubernetes-helm # Helm CLI
        kubectx # Kubernetes context manager
        kubelogin # Kubernete login manager by Azure
        kustomize # Kustomize CLI
      ];

      programs.zsh.shellAliases = { k = "kubectl"; };

      # Terminal Kubernetes UI
      programs.k9s = { enable = true; };

      home.file.k9s = {
        target = "${config.homePath}/.config/k9s/skin.yml";
        text = ''
          base: &base "#24273a"
          blue: &blue "#8aadf4"
          crust: &crust "#181926"
          flamingo: &flamingo "#f0c6c6"
          green: &green "#a6da95"
          lavender: &lavender "#b7bdf8"
          mantle: &mantle "#1e2030"
          maroon: &maroon "#ee99a0"
          mauve: &mauve "#c6a0f6"
          overlay0: &overlay0 "#6e738d"
          overlay1: &overlay1 "#8087a2"
          overlay2: &overlay2 "#939ab7"
          peach: &peach "#f5a97f"
          pink: &pink "#f5bde6"
          red: &red "#ed8796"
          rosewater: &rosewater "#f4dbd6"
          sapphire: &sapphire "#7dc4e4"
          sky: &sky "#91d7e3"
          subtext0: &subtext0 "#a5adcb"
          subtext1: &subtext1 "#b8c0e0"
          surface0: &surface0 "#363a4f"
          surface1: &surface1 "#494d64"
          surface2: &surface2 "#5b6078"
          teal: &teal "#8bd5ca"
          text: &text "#cad3f5"
          yellow: &yellow "#eed49f"

          # Skin...
          k9s:
            # General K9s styles
            body:
              fgColor: *text
              bgColor: *base
              logoColor: *mauve

            # Command prompt styles
            prompt:
              fgColor: *text
              bgColor: *mantle
              suggestColor: *blue

            # ClusterInfoView styles.
            info:
              fgColor: *peach
              sectionColor: *text

            # Dialog styles.
            dialog:
              fgColor: *yellow
              bgColor: *overlay2
              buttonFgColor: *base
              buttonBgColor: *overlay1
              buttonFocusFgColor: *base
              buttonFocusBgColor: *pink
              labelFgColor: *rosewater
              fieldFgColor: *text

            frame:
              # Borders styles.
              border:
                fgColor: *mauve
                focusColor: *lavender

              # MenuView attributes and styles
              menu:
                fgColor: *text
                keyColor: *blue
                # Used for favorite namespaces
                numKeyColor: *maroon

              # CrumbView attributes for history navigation.
              crumbs:
                fgColor: *base
                bgColor: *maroon
                activeColor: *flamingo

              # Resource status and update styles
              status:
                newColor: *blue
                modifyColor: *lavender
                addColor: *green
                pendingColor: *peach
                errorColor: *red
                highlightColor: *sky
                killColor: *mauve
                completedColor: *overlay0

              # Border title styles.
              title:
                fgColor: *teal
                bgColor: *base
                highlightColor: *pink
                counterColor: *yellow
                filterColor: *green

            views:
              # Charts skins...
              charts:
                bgColor: *base
                chartBgColor: *base
                dialBgColor: *base
                defaultDialColors:
                  - *green
                  - *red
                defaultChartColors:
                  - *green
                  - *red
                resourceColors:
                  cpu:
                    - *mauve
                    - *blue
                  mem:
                    - *yellow
                    - *peach

              # TableView attributes.
              table:
                fgColor: *text #Doesn't Work
                bgColor: *base
                cursorFgColor: *surface0 # Doesn't Work
                cursorBgColor: *surface1 # should be rosewater
                markColor: *rosewater # Doesn't Work
                # Header row styles.
                header:
                  fgColor: *yellow
                  bgColor: *base
                  sorterColor: *sky

              # Xray view attributes.
              xray:
                fgColor: *text #Doesn't Work
                bgColor: *base
                # Need to set this to a dark color since color text can't be changed
                # Ideally this would be rosewater
                cursorColor: *surface1
                cursorTextColor: *base #Doesn't Work
                graphicColor: *pink

              # YAML info styles.
              yaml:
                keyColor: *blue
                colonColor: *subtext0
                valueColor: *text

              # Logs styles.
              logs:
                fgColor: *text
                bgColor: *base
                indicator:
                  fgColor: *lavender
                  bgColor: *base

            help:
              fgColor: *text
              bgColor: *base
              sectionColor: *green
              keyColor: *blue
              numKeyColor: *maroon
        '';
      };

    };

  };

}
