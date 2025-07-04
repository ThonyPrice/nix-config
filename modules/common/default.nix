{ config, lib, pkgs, ... }: {

  imports = [ ./applications ./editors ./programming ./shell ];

  options = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of the system";
    };
    fullName = lib.mkOption {
      type = lib.types.str;
      description = "Human readable name of the user";
    };
    userDirs = {
      # Required to prevent infinite recursion when referenced by himalaya
      download = lib.mkOption {
        type = lib.types.str;
        description = "XDG directory for downloads";
        default =
          if pkgs.stdenv.isDarwin then "$HOME/Downloads" else "$HOME/downloads";
      };
    };
    identityFile = lib.mkOption {
      type = lib.types.str;
      description = "Path to existing private key file.";
      default = "/etc/ssh/ssh_host_ed25519_key";
    };
    gui = {
      enable = lib.mkEnableOption {
        description = "Enable graphics.";
        default = false;
      };
    };
    theme = {
      colors = lib.mkOption {
        type = lib.types.attrs;
        description = "Base16 color scheme.";
        default = (import ../colorscheme/gruvbox).dark;
      };
      dark = lib.mkOption {
        type = lib.types.bool;
        description = "Enable dark mode.";
        default = true;
      };
    };
    homePath = lib.mkOption {
      type = lib.types.path;
      description = "Path of user's home directory.";
      default = builtins.toPath (if pkgs.stdenv.isDarwin then
        "/Users/${config.user}"
      else
        "/home/${config.user}");
    };
    dotfilesPath = lib.mkOption {
      type = lib.types.path;
      description = "Path of dotfiles repository.";
      default = config.homePath + "/git/nix-config";
    };
    dotfilesRepo = lib.mkOption {
      type = lib.types.str;
      description = "Link to dotfiles repository HTTPS URL.";
    };
    unfreePackages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of unfree packages to allow.";
      default = [ ];
    };
    hostnames = {
      git = lib.mkOption {
        type = lib.types.str;
        description = "Hostname for git server (Gitea).";
      };
      metrics = lib.mkOption {
        type = lib.types.str;
        description = "Hostname for metrics server.";
      };
      prometheus = lib.mkOption {
        type = lib.types.str;
        description = "Hostname for Prometheus server.";
      };
      secrets = lib.mkOption {
        type = lib.types.str;
        description = "Hostname for passwords and secrets (Vaultwarden).";
      };
      stream = lib.mkOption {
        type = lib.types.str;
        description = "Hostname for video/media library (Jellyfin).";
      };
      content = lib.mkOption {
        type = lib.types.str;
        description = "Hostname for personal content system (Nextcloud).";
      };
      books = lib.mkOption {
        type = lib.types.str;
        description = "Hostname for books library (Calibre-Web).";
      };
      download = lib.mkOption {
        type = lib.types.str;
        description = "Hostname for download services.";
      };
    };
  };

  config = let stateVersion = "23.05";
  in {

    nix = {

      # Enable features in Nix commands
      extraOptions = ''
        experimental-features = nix-command flakes
        warn-dirty = false
      '';

      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };

      settings = {

        # Add community Cachix to binary cache
        # Don't use with macOS because blocked by corporate firewall
        builders-use-substitutes = true;
        substituters = lib.mkIf (!pkgs.stdenv.isDarwin)
          [ "https://nix-community.cachix.org" ];
        trusted-public-keys = lib.mkIf (!pkgs.stdenv.isDarwin) [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        # Scans and hard links identical files in the store
        # Not working with macOS: https://github.com/NixOS/nix/issues/7273
        auto-optimise-store = lib.mkIf (!pkgs.stdenv.isDarwin) true;

      };

    };

    # Basic common system packages for all devices
    environment.systemPackages = with pkgs; [ git vim wget curl ];

    # Use the system-level nixpkgs instead of Home Manager's
    home-manager.useGlobalPkgs = true;

    # Install packages to /etc/profiles instead of ~/.nix-profile, useful when
    # using multiple profiles for one user
    # home-manager.useUserPackages = true;

    # Allow specified unfree packages
    nixpkgs.config.allowUnfree = true;

    # Pin a state version to prevent warnings
    home-manager.users.${config.user}.home.stateVersion = stateVersion;
    # home-manager.users.root.home.stateVersion = stateVersion;

  };

}
