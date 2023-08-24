{ config, pkgs, lib, ... }: {

  config = lib.mkIf pkgs.stdenv.isDarwin {

    services.skhd = {

      enable = true;
      package = pkgs.skhd;
      skhdConfig = ''

        # Programs
        shift + cmd - return : ${pkgs.kitty}/bin/kitty --single-instance -d ~
        shift + cmd - m : /Applications/Slack.app/Contents/MacOS/Slack
        shift + cmd - u : launchctl stop org.nixos.yabai

        # focus window
        alt - h : yabai -m window --focus west
        alt - j : yabai -m window --focus south
        alt - k : yabai -m window --focus north
        alt - l : yabai -m window --focus east

        # swap window
        shift + alt - h : yabai -m window --swap west
        shift + alt - j : yabai -m window --swap south
        shift + alt - k : yabai -m window --swap north
        shift + alt - l : yabai -m window --swap east

        # move window
        shift + cmd - h : yabai -m window --warp west
        shift + cmd - j : yabai -m window --warp south
        shift + cmd - k : yabai -m window --warp north
        shift + cmd - l : yabai -m window --warp east

        # balance size of windows
        shift + alt - 0 : yabai -m space --balance

        # create desktop and follow focus - uses jq for parsing json (ibrew install jq)
        cmd + alt - n : yabai -m space --create && \
                        index="$(yabai -m query --spaces --display | jq 'map(select(."native-fullscreen" == 0))[-1].index')" && \
                        yabai -m space --focus "$\{index\}"

        # create desktop, move window and follow focus - uses jq for parsing json (brew install jq)
        # shift + cmd - n : yabai -m space --create && \
        #                   index="$(yabai -m query --spaces --display | jq 'map(select(."native-fullscreen" == 0))[-1].index')" && \
        #                   yabai -m window --space "$\{index\}" && \
        #                   yabai -m space --focus "$\{index}\"

        # destroy desktop
        cmd + alt - w : yabai -m space --destroy && \
                        yabai -m space --focus recent

        # fast focus desktop
        cmd + alt - x : yabai -m space --focus recent

        # send window to desktop and follow focus
        # shift + cmd - x : yabai -m window --space recent; yabai -m space --focus recent
        shift + alt - p : yabai -m window --space prev; yabai -m space --focus prev
        shift + alt - n : yabai -m window --space next; yabai -m space --focus next
        # shift + cmd - 1 : yabai -m window --space  1; yabai -m space --focus 1
        # shift + cmd - 2 : yabai -m window --space  2; yabai -m space --focus 2
        # shift + cmd - 3 : yabai -m window --space  3; yabai -m space --focus 3

        # send window to monitor and follow focus
        ctrl + cmd - x  : yabai -m window --display recent; yabai -m display --focus recent
        ctrl + cmd - z  : yabai -m window --display prev; yabai -m display --focus prev
        ctrl + cmd - c  : yabai -m window --display next; yabai -m display --focus next
        ctrl + cmd - 1  : yabai -m window --display 1; yabai -m display --focus 1
        ctrl + cmd - 2  : yabai -m window --display 2; yabai -m display --focus 2
        ctrl + cmd - 3  : yabai -m window --display 3; yabai -m display --focus 3

        # increase window size
        shift + alt - a : yabai -m window --resize left:-30:0
        shift + alt - s : yabai -m window --resize bottom:0:30
        shift + alt - w : yabai -m window --resize top:0:-30
        shift + alt - d : yabai -m window --resize right:30:0

        # decrease window size
        shift + cmd - a : yabai -m window --resize left:30:0
        shift + cmd - s : yabai -m window --resize bottom:0:-30
        shift + cmd - w : yabai -m window --resize top:0:30
        shift + cmd - d : yabai -m window --resize right:-30:0

        # set insertion point in focused container
        ctrl + alt - h : yabai -m window --insert west
        ctrl + alt - j : yabai -m window --insert south
        ctrl + alt - k : yabai -m window --insert north
        ctrl + alt - l : yabai -m window --insert east

        # rotate tree
        alt - r : yabai -m space --rotate 90

        # mirror tree y-axis
        alt - y : yabai -m space --mirror y-axis

        # mirror tree x-axis
        alt - x : yabai -m space --mirror x-axis

        # toggle desktop offset
        alt - w : yabai -m space --toggle padding; yabai -m space --toggle gap

        # toggle window parent zoom
        # alt - d : yabai -m window --toggle zoom-parent

        # toggle window fullscreen zoom
        alt - f : yabai -m window --toggle zoom-fullscreen;\
                  sketchybar --trigger window_focus

        # toggle window native fullscreen
        shift + alt - f : yabai -m window --toggle native-fullscreen

        # toggle window border
        shift + alt - b : yabai -m window --toggle border

        # toggle window split type
        alt - e : yabai -m window --toggle split

        # float / unfloat window and center on screen
        alt - t : yabai -m window --toggle float;\
                  yabai -m window --grid 4:4:1:1:2:2;\
                  sketchybar --trigger window_focus

        # change layout of desktop
        ctrl + alt - t : yabai -m space --layout bsp
        ctrl + alt - f : yabai -m space --layout float
        ctrl + shift - space : yabai -m space --layout "$(yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "stack" else "bsp" end')";\
                               sketchybar --trigger window_focus

        # manage stacked windows
        alt - p: yabai -m window --focus stack.prev
        alt - n: yabai -m window --focus stack.next

      '';

    };

  };

}

# { config, pkgs, lib, ... }: {
# 
#   home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin {
# 
#     home.packages = with pkgs; [ skhd ];
# 
#     home.file.skhd = {
#       source = ./skhdrc;
#       target = "${config.homePath}/.config/skhd/skhdrc";
#       executable = false;
#     };
# 
#     # Skhd on startup workaround
#     # https://github.com/noctuid/dotfiles/blob/e6d93d17d3723dad06c8277b7565035df836d938/nix/darwin/default.nix#L292
#     launchd.agents.skhd = {
#       enable = true;
#       config = {
#         ProgramArguments = [
#           "${pkgs.skhd}/bin/skhd"
#           "-c"
#           "${config.homePath}/.config/skhd/skhdrc"
#         ];
#         KeepAlive = true;
#         RunAtLoad = true;
#         ProcessType = "Interactive";
#         EnvironmentVariables = {
#           PATH = pkgs.lib.concatStringsSep ":" [
#             "${config.homePath}/.nix-profile/bin"
#           ];
#         };
#         StandardOutPath = "/tmp/skhd.log";
#         StandardErrorPath = "/tmp/skhd.log";
#       };
#     };
# 
#   };
# 
# }
