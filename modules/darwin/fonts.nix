{ config, pkgs, lib, ... }: {

  config = lib.mkIf pkgs.stdenv.isDarwin {

    fonts.packages = [
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.victor-mono
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.hack
      pkgs.nerd-fonts.symbols-only
    ];

    home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin { };

  };

}
