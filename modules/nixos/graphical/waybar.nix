{ config, pkgs, lib, ... }:

{

  config = lib.mkIf pkgs.stdenv.isLinux {

    environment.systemPackages = with pkgs; [ waybar swayosd ];

    # Fix permissions to edit backligt
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    '';

    home-manager.users.${config.user} = {
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
                   font-size: 9pt;
                   font-weight: bold;
                   border-radius: 0px;
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
                   padding-top: 3px;
                   padding-bottom: 3px;
                   padding-left: 6px;
                   padding-right: 6px;
                   color: #CDD6F4;
                 }
           #workspaces button.active {
                   background-color: #89b4fa
                   color: #24273A;
                 }
           #workspaces button.urgent {
                   color: #24273A;
                 }
           #custom-launcher {
                   font-size: 20px;
                   padding-left: 8px;
                   padding-right: 6px;
                   color: #74C7EC;
                 }
           #mode, #clock, #memory, #temperature,#cpu,#mpd, #custom-wall, #temperature, #backlight, #pulseaudio, #network, #battery, #custom-powermenu, #custom-cava-internal {
                   padding-left: 10px;
                   padding-right: 10px;
                 }
                 /* #mode { */
                 /* 	margin-left: 10px; */
                 /* 	background-color: rgb(248, 189, 150); */
                 /*     color: rgb(26, 24, 38); */
                 /* } */
           #memory {
                   color: #8bd5ca
                 }
           #cpu {
                   color: #8bd5ca
                 }
           #clock {
                   color: #cdd6f4
                 }
          /* #idle_inhibitor {
                   color: rgb(221, 182, 242);
                 }*/
           #custom-wall {
                   color: rgb(221, 182, 242);
              }
           #temperature {
                   color: rgb(150, 205, 251);
                 }
           #backlight {
                   color: rgb(248, 189, 150);
                 }
           #pulseaudio {
                   color: #f0c6c6
                 }
           #network {
                   color: #a6e3a1
                 }

           #network.disconnected {
                   color: #ed8796
                 }
           #battery.charging, #battery.full, #battery.discharging {
                   color: #eed49f
                 }
           #battery.critical:not(.charging) {
                   color: #ed8796
                 }
           #custom-powermenu {
                   color: #ed8796
                 }
           #tray {
                   padding-right: 8px;
                   padding-left: 10px;
                 }
           #mpd.paused {
                   color: #414868;
                   font-style: italic;
                 }
           #mpd.stopped {
                   background: transparent;
                 }
           #mpd {
                   color: #c0caf5;
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
            # "temperature"
            # "idle_inhibitor"
            # "custom/wall"
            # "mpd"
            # "custom/cava-internal"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "pulseaudio"
            # "backlight"
            # "memory"
            # "cpu"
            "network"
            "battery"
            "custom/powermenu"
            "tray"
          ];
          "custom/launcher" = {
            "format" = " ";
            "on-click" = "pkill rofi || ~/.config/rofi/launcher.sh";
            "tooltip" = false;
          };
          "custom/wall" = {
            "on-click" = "wallpaper_random";
            "on-click-middle" = "default_wall";
            "on-click-right" =
              "killall dynamic_wallpaper || dynamic_wallpaper &";
            "format" = " 󰠖 ";
            "tooltip" = false;
          };
          "custom/cava-internal" = {
            "exec" = "sleep 1s && cava-internal";
            "tooltip" = false;
          };
          "hyprland/workspaces" = {
            "format" = "{name}";
            "on-click" = "activate";
          };
          "idle_inhibitor" = {
            "format" = "{icon}";
            "format-icons" = {
              "activated" = "";
              "deactivated" = "";
            };
            "tooltip" = false;
          };
          "backlight" = {
            "device" = "intel_backlight";
            "on-scroll-up" = "light -A 5";
            "on-scroll-down" = "light -U 5";
            "format" = "{icon} {percent}%";
            "format-icons" = [ "󰃝" "󰃞" "󰃟" "󰃠" ];
          };
          "pulseaudio" = {
            "scroll-step" = 1;
            "format" = "{icon} {volume}%";
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
          "mpd" = {
            "max-length" = 25;
            "format" = "<span foreground='#bb9af7'></span> {title}";
            "format-paused" = " {title}";
            "format-stopped" = "<span foreground='#bb9af7'></span>";
            "format-disconnected" = "";
            "on-click" = "mpc --quiet toggle";
            "on-click-right" = "mpc update; mpc ls | mpc add";
            "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp ";
            "on-scroll-up" = "mpc --quiet prev";
            "on-scroll-down" = "mpc --quiet next";
            "smooth-scrolling-threshold" = 5;
            "tooltip-format" =
              "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
          };
          "network" = {
            "format-disconnected" = "󰯡 Disconnected";
            "format-ethernet" = "󰀂 {ifname} ({ipaddr})";
            "format-linked" = "󰖪 {essid} (No IP)";
            "format-wifi" = "󰖩 {essid}";
            "interval" = 1;
            "tooltip" = false;
          };
          "temperature" = {
            # "hwmon-path"= "${env:HWMON_PATH}";
            #"critical-threshold"= 80;
            "tooltip" = false;
            "format" = " {temperatureC}°C";
          };
          "custom/powermenu" = {
            "format" = "";
            "on-click" = "pkill rofi || ~/.config/rofi/powermenu.sh";
            "tooltip" = false;
          };
          "tray" = {
            "icon-size" = 15;
            "spacing" = 5;
          };
        }];
      };

    };

  };

}
