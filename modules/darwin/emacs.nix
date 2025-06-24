{ config, pkgs, lib, ... }: {

  config = lib.mkIf (pkgs.stdenv.isDarwin && config.emacs.enable) {

    # Setup emacs path and daemon on login
    launchd.user.agents.emacs.path = [ config.environment.systemPath ];
    launchd.user.agents.emacs.serviceConfig = {
      KeepAlive = true;
      ProgramArguments = [ "emacs" "--daemon" ];
      StandardErrorPath = "/tmp/emacs.log";
      StandardOutPath = "/tmp/emacs.log";
    };

  };

}
