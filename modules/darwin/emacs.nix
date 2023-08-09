{ config, pkgs, lib, ... }: {

  config = lib.mkIf pkgs.stdenv.isDarwin {

    # Setup emacs path and daemon on login
    launchd.user.agents.emacs.path = [ config.environment.systemPath ];
    launchd.user.agents.emacs.serviceConfig = {
      KeepAlive = true;
      ProgramArguments = [ "${pkgs.emacs-unstable}/bin/emacs" "--daemon" ];
      StandardErrorPath = "/tmp/emacs.log";
      StandardOutPath = "/tmp/emacs.log";
    };

  };

}
