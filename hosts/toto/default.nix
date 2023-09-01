{ inputs, globals, overlays, ... }:

inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs; }; # Required for Hyprland
  modules = [
    ./configuration.nix # TODO: Merge with flake configs
    ./hardware.nix
    ../../modules/common
    ../../modules/nixos
    (globals // rec {
       user = "thony";
       gitName = "thonyprice";
       gitEmail = "thony.price@gmail.com";
    })
    inputs.home-manager.nixosModules.home-manager
    {
      nixpkgs.overlays = [
        inputs.emacs-overlay.overlay
      ] ++ overlays;
      networking.hostName = "toto";

      # Wayland/Hyprland
      programs.hyprland = {
        enable = true;
         package = inputs.hyprland.packages.x86_64-linux.hyprland;
      };

      # identityFile = "/Users/thony/.ssh/id_ed25519";

      gui.enable = true;

      # Applications
      kitty.enable = true;
      slack.enable = true;
      spotify.enable = true;

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
