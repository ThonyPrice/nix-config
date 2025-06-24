{ pkgs, lib, ... }: {

  config = lib.mkIf pkgs.stdenv.isDarwin {

    system.primaryUser = "thony";

    system.stateVersion = 4;
    # services.nix-daemon.enable = true;

    # This setting only applies to Darwin, different on NixOS
    nix.gc.interval = {
      Hour = 12;
      Minute = 15;
      Day = 1;
    };

    environment.shells = [ pkgs.zsh ];

    # security.pam.enableSudoTouchIdAuth = true;

    system = {

      keyboard = {
        remapCapsLockToEscape = true;
        enableKeyMapping = true; # Allows for skhd
      };

      defaults = {
        NSGlobalDomain = {

          # Set to dark mode
          AppleInterfaceStyle = "Dark";

          # Don't change from dark to light automatically
          # AppleInterfaceSwitchesAutomatically = false;

          # Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
          AppleKeyboardUIMode = 3;

          # Automatically show and hide the menu bar
          _HIHideMenuBar = true;

          # Expand save panel by default
          NSNavPanelExpandedStateForSaveMode = true;

          # Expand print panel by default
          PMPrintingExpandedStateForPrint = true;

          # Replace press-and-hold with key repeat
          ApplePressAndHoldEnabled = false;

          # Set a fast key repeat rate
          KeyRepeat = 2;

          # Shorten delay before key repeat begins
          InitialKeyRepeat = 12;

          # Save to local disk by default, not iCloud
          NSDocumentSaveNewDocumentsToCloud = false;

          # Disable autocorrect capitalization
          NSAutomaticCapitalizationEnabled = false;

          # Disable autocorrect smart dashes
          NSAutomaticDashSubstitutionEnabled = false;

          # Disable autocorrect adding periods
          NSAutomaticPeriodSubstitutionEnabled = false;

          # Disable autocorrect smart quotation marks
          NSAutomaticQuoteSubstitutionEnabled = false;

          # Disable autocorrect spellcheck
          NSAutomaticSpellingCorrectionEnabled = false;
        };

        dock = {
          # Automatically show and hide the dock
          autohide = true;

          # Add translucency in dock for hidden applications
          showhidden = true;

          # Highlight hover effect in dock stack grid view
          mouse-over-hilite-stack = true;

          # Remove animations
          expose-animation-duration = 0.0;

          show-recents = false;
          launchanim = false;
          mru-spaces = false;
          orientation = "left";
          tilesize = 32;
        };

        finder = {

          # Default Finder window set to column view
          FXPreferredViewStyle = "clmv";

          # Finder search in current folder by default
          FXDefaultSearchScope = "SCcf";

          # Disable warning when changing file extension
          FXEnableExtensionChangeWarning = false;

          # Allow quitting of Finder application
          QuitMenuItem = true;

          # Shpw extentions
          AppleShowAllExtensions = true;

          # POSIX path please
          _FXShowPosixPathInTitle = false;

        };

        trackpad = {

          # Set click on touch
          Clicking = true;

          # Gesture to move windows
          TrackpadThreeFingerDrag = true;

        };

        # Set "Are you sure you want to open" dialog
        LaunchServices.LSQuarantine = true;

        # Where to save screenshots
        screencapture.location = "~/Desktop";

      };

    };

  };

}
