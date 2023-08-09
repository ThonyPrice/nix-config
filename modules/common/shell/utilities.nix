{ config, pkgs, ... }:

let

  ignorePatterns = ''
    !.env*
    !.github/
    !.gitignore
    !*.tfvars
    .terraform/
    .target/
    /Library/'';

in {

  config = {

    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        age # Encryption
        bc # Calculator
        btop # Show system processes
        curl # Url fetcher
        dig # DNS lookup
        killall # Force quit
        less # Pager
        jq # JSON manipulation
        lf # File viewer
        qrencode # Generate qr codes
        rsync # Copy folders
        sd # sed
        tree # View directory hierarchy
        unzip # Extract zips
        dua # File sizes (du)
        duf # Basic disk information (df)
      ];

      home.file = {
        ".rgignore".text = ignorePatterns;
        ".fdignore".text = ignorePatterns;
        ".digrc".text = "+noall +answer"; # Cleaner dig commands
      };

      programs.bat = {
        enable = true; # cat replacement
        themes = {
          catppuccin-macchiato =
            builtins.readFile (pkgs.fetchFromGitHub {
              owner = "catppuccin";
              repo = "bat";
              rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
              sha256 = "6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
            } + "/Catppuccin-macchiato.tmTheme");
        };
        config = {
          theme = "catppuccin-macchiato";
          pager = "less -R"; # Don't auto-exit if one screen
        };

      };

    };

  };

}
