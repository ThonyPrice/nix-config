{ config, pkgs, lib, ... }: {

  # Homebrew - Mac-specific packages that aren't in Nix
  config = lib.mkIf pkgs.stdenv.isDarwin {

    # Requires Homebrew to be installed
    # system.activationScripts.preUserActivation.text = ''
    #   if ! xcode-select --version 2>/dev/null; then
    #     $DRY_RUN_CMD xcode-select --install
    #   fi
    #   if ! /usr/local/bin/brew --version 2>/dev/null; then
    #     $DRY_RUN_CMD /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    #   fi
    # '';

    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = false; # Don't update during rebuild
        cleanup = "zap"; # Uninstall all programs not declared
        upgrade = true;
      };
      global = {
        brewfile = true; # Run brew bundle from anywhere
        lockfiles = false; # Don't save lockfile (since running from anywhere)
      };
      brewPrefix = "/opt/homebrew/bin";
      taps = [
        "homebrew/cask" # Required for casks
        "homebrew/cask-fonts" # For fonts
        "homebrew/services" # Nice to have?
      ];
      brews = [ ];
      casks = [
        "1password" # 1Password packaging on Nix is broken for macOS
        "appcleaner" # Uninstall helper
        "balenaetcher" # Flash OS images
        "dropbox" # Used for Orgzly syncs
        "launchcontrol" # Launchctl GUI
        "pgadmin4" # Admin/dev platform for PostgreSQL
        "raycast" # Application launcher
        "sf-symbols" # Font for sketchybar
      ];
    };

  };

}
