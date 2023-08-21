{ config, pkgs, lib, ... }: {

  options.postgres.enable = lib.mkEnableOption "PostgreSQL and tooling.";

  config = lib.mkIf config.postgres.enable {
    home-manager.users.${config.user} = {

      home.packages = with pkgs;
        [
          postgresql
          # pgadmin4 # Admin/dev platform for PostgreSQL
        ];
    };
  };
}
