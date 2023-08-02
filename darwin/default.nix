{ config, pkgs, nixpkgs, ... }:

let
  home = builtins.getEnv "HOME";
  emacsOverlaySha256 =
    # Forked 2023-08-01
    "01q8bw40dh350zjx7g50ib4599sbsjgg711f794ib4d21ixh9xai";
  user = "thony"; in
{

  imports = [
    ../common
    ./home-manager.nix
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Setup user, packages, programs
  nix = {
    package = pkgs.nixUnstable;
    settings.trusted-users = [ "@admin" "${user}" ];

    gc = {
      # Nix garbage collector
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    # Turn this on to make command line easier
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Define overlays
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/thonyprice/emacs-overlay/archive/master.tar.gz";
      sha256 = emacsOverlaySha256;
    }))
  ];

  # Turn off NIX_PATH warnings when using flakes
  system.checks.verifyNixPath = false;

  # Manage fonts
  fonts.fontDir.enable = false; # DANGER
  # fonts.fonts =
    # [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];

  # Load configuration that is shared across systems
  environment = {
    loginShell = pkgs.zsh;
    shells = [ pkgs.bash pkgs.zsh ];
    systemPackages = with pkgs; [
      pkgs.emacs-unstable  # Installs Emacs 28 + native-comp
    ] ++ (import ../common/packages.nix { pkgs = pkgs; });
  };

  launchd.user.agents.emacs.path = [ config.environment.systemPath ];
  launchd.user.agents.emacs.serviceConfig = {
    KeepAlive = true;
    ProgramArguments = [
      "${pkgs.emacs-git}/bin/emacs"
      "--daemon"
      # Force Yabaii to manage emacsclients
      "yabai --restart-service" # 
    ];
    StandardErrorPath = "/tmp/emacs.err.log";
    StandardOutPath = "/tmp/emacs.out.log";
  };

  system = {
    stateVersion = 4;

    defaults = {
      LaunchServices = {
        LSQuarantine = false;
      };

      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;
        AppleInterfaceStyle = "Dark";
        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = true;
        expose-animation-duration = 0.0;
        show-recents = false;
        launchanim = false;
        mru-spaces = false;
        orientation = "left";
        tilesize = 32;
      };

      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
}
