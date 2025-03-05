# Configuration specifics for host Laika.
# That is, config that's not shared with any other host.

{ config, pkgs, lib, ... }: {

  home-manager.users.${config.user} = {

    home.sessionVariables = {
      # Prettier log format
      CAREOS_LOG_FORMAT = "PLAIN";
      REOS_ENABLE_SHUTDOWN_HOOKS = "false";
    };

    home.packages = with pkgs; [
      turbo # High-performance build system for JavaScript and TypeScript codebases
      watchman # React native dev environment nice to have
    ];

    programs.zsh.shellAliases = {
      # Aliases to run dependent services
      run-doa =
        "npx turbo run dev --filter='*doa*' --filter='*file-persister*' --filter='*config*' --filter='*organization*'";
      run-e2e =
        "npx turbo run dev --filter='*doa*' --filter='*file-persister*' --filter='*config*' --filter='*organization*' --filter='*mro*' --filter='*collection*' --filter='*gates*' --filter='*workplace*' --filter='*finalizer*' --filter='*cgm*' --filter='*event-dump*' --filter='*maestro*' --concurrency=20";
    };
  };
}
