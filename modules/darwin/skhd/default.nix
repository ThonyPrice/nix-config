{ config, pkgs, lib, ... }: {

  home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin {

    home.packages = with pkgs; [ skhd ];

    home.file.skhd = {
      source = ./skhdrc;
      target = "${config.homePath}/.config/skhd/skhdrc";
      executable = false;
    };

    # Skhd on startup workaround
    # https://github.com/noctuid/dotfiles/blob/e6d93d17d3723dad06c8277b7565035df836d938/nix/darwin/default.nix#L292
    launchd.agents.skhd = {
      enable = true;
      config = {
        ProgramArguments = [
          "${pkgs.skhd}/bin/skhd"
          "-c"
          "${config.homePath}/.config/skhd/skhdrc"
        ];
        KeepAlive = true;
        RunAtLoad = true;
        ProcessType = "Interactive";
        EnvironmentVariables = {
          PATH = pkgs.lib.concatStringsSep ":" [
            "${config.homePath}/.nix-profile/bin"
          ];
        };
        StandardOutPath = "/tmp/skhd.log";
        StandardErrorPath = "/tmp/skhd.log";
      };
    };

  };

}
