{ config, pkgs, lib, ... }:

{

  config = lib.mkIf pkgs.stdenv.isLinux {

    home-manager.users.${config.user} = {

      programs.rofi = {
        enable = true;
        cycle = true;
        location = "center";
        font = "Fira Code Font 8";
        package = pkgs.rofi-wayland;
        plugins = [
          (pkgs.rofi-calc.override {
            rofi-unwrapped = pkgs.rofi-wayland-unwrapped;
          })
          pkgs.rofi-power-menu
        ];
        extraConfig = {
          show-icons = true;
          kb-cancel = "Escape,Super+space";
          modi = "window,run,ssh,drun,calc";
          sort = true;
        };
        theme = "catppuccin-macchiato";
      };

      home.file.".config/rofi/themes/catppuccin-macchiato.rasi" = {
        text = ''
          * {
            bg-col:  #24273a;
            bg-col-light: #24273a;
            border-col: #24273a;
            selected-col: #24273a;
            blue: #8aadf4;
            fg-col: #cad3f5;
            fg-col2: #ed8796;
            grey: #6e738d;
            width: 400;
          }

          element-text, element-icon , mode-switcher {
            background-color: inherit;
            text-color:       inherit;
          }

          window {
            height: 260px;
            border: 3px;
            border-color: @border-col;
            background-color: @bg-col;
          }

          mainbox {
            background-color: @bg-col;
          }

          inputbar {
            children: [prompt,entry];
            background-color: @bg-col;
            border-radius: 5px;
            padding: 2px;
          }

          prompt {
            background-color: @blue;
            padding: 6px;
            text-color: @bg-col;
            border-radius: 3px;
            margin: 20px 0px 0px 20px;
          }

          textbox-prompt-colon {
            expand: false;
            str: ":";
          }

          entry {
            padding: 6px;
            margin: 20px 0px 0px 10px;
            text-color: @fg-col;
            background-color: @bg-col;
          }

          listview {
            border: 0px 0px 0px;
            padding: 6px 0px 0px;
            margin: 10px 0px 0px 20px;
            columns: 1;
            lines: 8;
            background-color: @bg-col;
          }

          element {
            padding: 5px;
            background-color: @bg-col;
            text-color: @fg-col  ;
          }

          element-icon {
            size: 25px;
          }

          element selected {
            background-color:  @selected-col ;
            text-color: @fg-col2  ;
          }

          mode-switcher {
            spacing: 0;
          }

          button {
            padding: 10px;
            background-color: @bg-col-light;
            text-color: @grey;
            vertical-align: 0.5;
            horizontal-align: 0.5;
          }

          button selected {
            background-color: @bg-col;
            text-color: @blue;
          }

          message {
            background-color: @bg-col-light;
            margin: 2px;
            padding: 2px;
            border-radius: 5px;
          }

          textbox {
            padding: 6px;
            margin: 20px 0px 0px 20px;
            text-color: @blue;
            background-color: @bg-col-light;
          }
        '';

      };

    };

  };

}
