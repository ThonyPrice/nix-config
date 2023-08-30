# Pluto. System configuration for my work Macbook

{ inputs, globals, overlays, ... }:

inputs.darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  specialArgs = { };
  modules = [
    ../../modules/common
    ../../modules/darwin
    (globals // rec {
      user = "thony";
      gitName = "thonyprice";
      gitEmail = "thony.price@gmail.com";
    })
    inputs.home-manager.darwinModules.home-manager
    {
      nixpkgs.overlays =
        [ inputs.firefox-darwin.overlay inputs.emacs-overlay.overlay ]
        ++ overlays;
      networking.hostName = "pluto";
      # identityFile = "/Users/thony/.ssh/id_ed25519";
      gui.enable = true;

      # Applications
      chromium.enable = false; # No build for Darwin
      kitty.enable = true;
      slack.enable = true;
      spotify.enable = true;

      raycast.enable = true;

      # Editors
      emacs.enable = true;
      neovim.enable = true;
      vscode.enable = true;

      # Programming
      go.enable = true;
      javascript.enable = true;
      kubernetes.enable = true;
      nixlang.enable = true;
      python.enable = true;
      postgres.enable = true;
      terraform.enable = true;

    }
  ];
}
