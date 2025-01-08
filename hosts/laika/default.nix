# Laika. System configuration for client Macbook Pro

{ inputs, globals, overlays, ... }:

inputs.darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  specialArgs = { };
  modules = [
    ../../modules/common
    ../../modules/darwin
    ./laika.nix
    (globals // rec {
      user = "thony";
      gitName = "thony-abclabs";
      gitEmail = "thony@abclabs.se";
    })
    inputs.home-manager.darwinModules.home-manager
    {
      nixpkgs.overlays =
        [ inputs.firefox-darwin.overlay inputs.emacs-overlay.overlay ]
        ++ overlays;
      networking.hostName = "Thonys-MBP";
      # identityFile = "/Users/thony/.ssh/id_ed25519";
      gui.enable = true;
      aerospace.enable = true;
      yabai.enable = false;
      skhd.enable = false;

      # Applications
      kitty.enable = true;
      slack.enable = true;
      spotify.enable = true;
      syncthing.enable = true;

      raycast.enable = true;

      # Editors
      emacs.enable = true;
      neovim.enable = true;
      vscode.enable = true;

      # Programming
      nixlang.enable = true;
      javascript.enable = true;
      kubernetes.enable = true;
      terraform.enable = true;
      python.enable = true;
      postgres.enable = true;

    }
  ];
}
