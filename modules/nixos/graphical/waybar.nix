{ config, pkgs, lib, ... }:

{

  config = lib.mkIf pkgs.stdenv.isLinux {

    environment.systemPackages = with pkgs; [ waybar swayosd ];

    # Fix permissions to edit backligt
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    '';

    home-manager.users.${config.user} = {

      # SwayOSd
      services.swayosd = { enable = true; };

      # Waybar
      programs.waybar = {
        enable = true;
        package = pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
        systemd = {
          enable = false;
          target = "graphical-session.target";
        };
        style = ''
          * {
            font-family: "JetBrainsMono Nerd Font";
            font-size: 8pt;
            font-weight: bold;
            border-radius: 0px;
            min-height: 0px;
            transition-property: background-color;
            transition-duration: 0.3s;
          }
          @keyframes blink_red {
            to {
              background-color: rgb(242, 143, 173);
              color: rgb(26, 24, 38);
            }
          }
          .warning, .critical, .urgent {
            animation-name: blink_red;
            animation-duration: 1s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
          }
          window#waybar {
            background-color: transparent;
          }
          window > box {
            margin-left: 0px;
            margin-right: 0px;
            margin-top: 0px;
            background-color: #24273A;
          }
          #workspaces {
            padding-left: 0px;
            padding-right: 4px;
            color: #24273A;
          }
          #workspaces button {
            padding-top: 2px;
            padding-bottom: 2px;
            padding-left: 4px;
            padding-right: 4px;
            color: #CDD6F4;
          }
          #workspaces button.active {
            background-color: #89b4fa;
            color: #24273A;
          }
          #workspaces button.urgent {
            color: #24273A;
          }
          #custom-launcher {
            font-size: 14px;
            padding-left: 12px;
            color: #74C7EC;
          }
          #mode, #clock, #memory, #temperature,#cpu,#mpd, #custom-wall, #temperature, #backlight, #pulseaudio, #network, #battery, #custom-powermenu, #custom-cava-internal {
            padding-left: 4px;
            padding-right: 4px;
          }
          #mode {
            margin-left: 10px;
            background-color: rgb(248, 189, 150);
            color: rgb(26, 24, 38);
          }
          #memory {
            color: #cdd6f4;
                 }
          #cpu {
            color: #cdd6f4;
          }
          #clock {
            color: #cdd6f4;
            padding-right: 12px;
          }
          #pulseaudio {
            color: #cdd6f4;
          }
          #network {
            color: #cdd6f4;
          }
          #network.disconnected {
            color: #ed8796;
          }
          #battery.charging {
            color: #a6da95;
          }
          #battery.full, #battery.discharging {
            color: #cdd6f4;
          }
          #battery.critical:not(.charging) {
            color: #ed8796;
          }
          #custom-powermenu {
            color: #ed8796;
          }
          #tray {
            padding-right: 4px;
            padding-left: 4px;
          }
          #custom-cava-internal{
            font-family: "Hack Nerd Font" ;
          }
        '';
        settings = [{
          "layer" = "top";
          "position" = "top";
          modules-left = [
            "custom/launcher"
            "hyprland/workspaces"
            # "idle_inhibitor"
            # "custom/cava-internal"
          ];
          modules-right = [
            # "memory"
            # "cpu"
            "tray"
            "pulseaudio"
            "battery"
            "network"
            "clock"
          ];
          "custom/launcher" = {
            "format" = " ";
            "on-click" = "pkill rofi || ~/.config/rofi/launcher.sh";
            "tooltip" = false;
          };
          "hyprland/workspaces" = {
            "format" = "{name}";
            "on-click" = "activate";
          };
          "pulseaudio" = {
            "scroll-step" = 1;
            "format" = "{icon}  {volume}%";
            "format-muted" = "󰖁 Muted";
            "format-icons" = { "default" = [ "" "" "" ]; };
            "on-click" = "pamixer -t";
            "tooltip" = false;
          };
          "battery" = {
            "interval" = 10;
            "states" = {
              "warning" = 20;
              "critical" = 10;
            };
            "format" = "{icon} {capacity}%";
            "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            "format-full" = "{icon} {capacity}%";
            "format-charging" = "󰂄 {capacity}%";
            "tooltip" = false;
          };
          "clock" = {
            "interval" = 1;
            "format" = "{:%H:%M}";
            "tooltip" = true;
            "tooltip-format" = ''
              晚上：Golang
              <tt>{calendar}</tt>'';
          };
          "memory" = {
            "interval" = 1;
            "format" = "󰍛 {percentage}%";
            "states" = { "warning" = 85; };
          };
          "cpu" = {
            "interval" = 1;
            "format" = "󰻠 {usage}%";
          };
          "network" = {
            "format-disconnected" = "󰯡";
            "format-ethernet" = "󰀂";
            "format-linked" = "󰖪";
            "format-wifi" = "󰖩";
            "interval" = 1;
            "tooltip" = false;
          };
          "tray" = {
            "icon-size" = 12;
            "spacing" = 4;
          };
        }];
      };

    };

  };

}
