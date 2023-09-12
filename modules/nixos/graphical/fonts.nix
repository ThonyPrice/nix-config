{ config, pkgs, lib, ... }:

let fontName = "Fira Code";

in {

  config = lib.mkIf (config.gui.enable && pkgs.stdenv.isLinux) {

    fonts.packages = with pkgs; [
      victor-mono # Used for Vim and Terminal
      (nerdfonts.override {
        fonts = [ "FiraCode" "Hack" "JetBrainsMono" ];
      }) # For Polybar, Rofi
    ];
    fonts.fontconfig.defaultFonts.monospace = [ fontName ];

    home-manager.users.${config.user} = {
      services.polybar.config."bar/main".font-0 = "Hack Nerd Font:size=10;2";
      programs.alacritty.settings.font.normal.family = fontName;
      programs.kitty.font.name = fontName;
      services.dunst.settings.global.font = "Hack Nerd Font 14";
    };

  };

}
