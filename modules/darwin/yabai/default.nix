{ config, pkgs, lib, ... }: {

  config = lib.mkIf pkgs.stdenv.isDarwin {

    # Setup Yabai tiling window manager
    services.yabai = {

      enable = true;
      enableScriptingAddition = true;
      package = pkgs.yabai;
      config = {

        # Global settings
        mouse_follows_focus = "off";
        focus_follows_mouse = "off";
        window_placement = "second_child";
        window_topmost = "off";
        window_opacity = "off";
        window_shadow = "off";

        active_window_opacity = "1.0";
        normal_window_opacity = "0.70";
        window_border = "on";
        window_border_width = "2";
        window_border_radius = "6";
        active_window_border_color = "0xffB7BDF8";
        normal_window_border_color = "0xef939AB7";
        split_ratio = "0.50";
        auto_balance = "off";
        mouse_modifier = "fn";
        mouse_action1 = "move";
        mouse_action2 = "resize";

        # General space settings
        layout = "bsp";
        external_bar = "all:42:0";
        top_padding = "8";
        bottom_padding = "8";
        left_padding = "8";
        right_padding = "8";
        window_gap = "8";

      };

      extraConfig = ''
        # # Unload the macOS WindowManager process
        # launchctl unload -F /System/Library/LaunchAgents/com.apple.WindowManager.plist > /dev/null 2>&1 &

        # # Sketchybar signals
        yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
        yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
        yabai -m signal --add event=window_created action="sketchybar --trigger windows_on_spaces"
        yabai -m signal --add event=window_destroyed action="sketchybar --trigger windows_on_spaces"

        # # Force yabai to handle Emacs
        yabai -m rule --add label="^[Ee]macs$" app="^(E|e)macs$" manage=on

        # # Exclude problematic apps from being managed:
        yabai -m rule --add app="^(Live|Calculator|Software Update|Dictionary|VLC|System Preferences|System Settings|Photo Booth|Archive Utility|Python|App Store|Alfred|Activity Monitor)$" manage=off
        yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
        yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off

        # # Run Yabai with sudo privileges but at default user
        # sudo -u ${config.user} ${config.homePath}/.config/yabai/yabairc
        echo "yabai configuration loaded.."

      '';
    };

  };

}
