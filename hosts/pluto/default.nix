# The Looking Glass
# System configuration for my work Macbook

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
      nixpkgs.overlays = [
        inputs.firefox-darwin.overlay
        inputs.emacs-overlay.overlay
      ] ++ overlays;
      networking.hostName = "pluto";
      # identityFile = "/Users/thony/.ssh/id_ed25519";
      gui.enable = true;

      # Applications
      kitty.enable = true;
      slack.enable = true;
      spotify.enable = true;
      
      raycast.enable = true;

      # Editors
      emacs.enable = true;
      neovim.enable = true;

      # Programming
      go.enable = true;
      kubernetes.enable = true;
      nixlang.enable = true;
      python.enable = false;
      terraform.enable = true;

    }
  ];
}
