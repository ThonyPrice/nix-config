{ config, pkgs, lib, ... }: {

  options = {
    kitty = {
      enable = lib.mkEnableOption {
        description = "Enable Kitty.";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gui.enable && config.kitty.enable) {

    # Set the Rofi-Systemd terminal for viewing logs
    # Using optionalAttrs because only available in NixOS
    environment = { } // lib.attrsets.optionalAttrs
      (builtins.hasAttr "sessionVariables" config.environment) {
        sessionVariables.ROFI_SYSTEMD_TERM = "${pkgs.kitty}/bin/kitty";
      };

    home-manager.users.${config.user} = {

      # Set the i3 terminal
      xsession.windowManager.i3.config.terminal =
        lib.mkIf pkgs.stdenv.isLinux "kitty";

      # Set the Rofi terminal for running programs
      programs.rofi.terminal =
        lib.mkIf pkgs.stdenv.isLinux "${pkgs.kitty}/bin/kitty";

      # Display images in the terminal
      programs.zsh.shellAliases = {
        icat = "kitty +kitten icat";
        ssh = "kitty +kitten ssh";
      };

      programs.kitty = {
        enable = true;
        extraConfig = (builtins.readFile ./kitty.conf);
        settings = {

          # The basic colors
          foreground = "#CAD3F5";
          background = "#24273A";
          selection_foreground = "#24273A";
          selection_background = "#F4DBD6";

          # Cursor colors
          cursor = "#F4DBD6";
          cursor_text_color = "#24273A";

          # URL underline color when hovering with mouse
          url_color = "#F4DBD6";

          # Kitty window border colors
          active_border_color = "#B7BDF8";
          inactive_border_color = "#6E738D";
          bell_border_color = "#EED49F";

          # OS Window titlebar colors
          wayland_titlebar_color = "system";
          macos_titlebar_color = "system";

          # Tab bar colors
          active_tab_foreground = "#181926";
          active_tab_background = "#C6A0F6";
          inactive_tab_foreground = "#CAD3F5";
          inactive_tab_background = "#1E2030";
          tab_bar_background = "#24273A";

          # Colors for marks (marked text in the terminal)
          mark1_foreground = "#24273A";
          mark1_background = "#B7BDF8";
          mark2_foreground = "#24273A";
          mark2_background = "#C6A0F6";
          mark3_foreground = "#24273A";
          mark3_background = "#7DC4E4";

          # The 16 terminal colors
          # - black
          color0 = "#494D64";
          color8 = "#5B6078";
          # - red
          color1 = "#ED8796";
          color9 = "#ED8796";
          # - green
          color2 = "#A6DA95";
          color10 = "#A6DA95";
          # - yellow
          color3 = "#EED49F";
          color11 = "#EED49F";
          # - blue
          color4 = "#8AADF4";
          color12 = "#8AADF4";
          # - magenta
          color5 = "#F5BDE6";
          color13 = "#F5BDE6";
          # - cyan
          color6 = "#8BD5CA";
          color14 = "#8BD5CA";
          # - white
          color7 = "#B8C0E0";
          color15 = "#A5ADCB";

          font_family = "JetBrainsMono Nerd Font";
          font_size = 9;
          adjust_line_height = "100%";

          cursor_blink_interval = 0;
          window_padding_width = 10;
          hide_window_decorations = "yes";
          remember_window_size = "no";
          initial_window_width = 1000;
          initial_window_height = 650;
          enable_audio_bell = "no";

          tab_bar_margin_width = 9;
          tab_bar_margin_height = "9 0";
          tab_bar_style = "separator";
          tab_bar_min_tabs = 2;
          tab_separator = "";
          tab_title_template =
            "{fmt.fg._5b6078}{fmt.bg._24273A}{fmt.fg._abb2bf}{fmt.bg._5b6078} {title.split()[0]} {fmt.fg._5b6078}{fmt.bg._24273A} ";
          active_tab_title_template =
            "{fmt.fg._a6da95}{fmt.bg._24273A}{fmt.fg._24273A}{fmt.bg._a6da95} {title.split()[0]} {fmt.fg._a6da95}{fmt.bg._24273A} ";
        };
      };
    };
  };
}
