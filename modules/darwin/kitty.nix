{ config, pkgs, lib, ... }: {

  # MacOS-specific settings for Kitty
  home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin {
    programs.kitty = {
      darwinLaunchOptions = [ "--start-as=fullscreen" ];
      #font.size = lib.mkForce 20;
      settings = {
        shell = "/run/current-system/sw/bin/zsh";
        macos_quit_when_last_window_closed = true;
        disable_ligatures = "always";
      };
    };
  };

}
