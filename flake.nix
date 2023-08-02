{
  description = "Thony's System Configuration";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixpkgs-unstable"; };
    home-manager = { url = "github:nix-community/home-manager"; };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = { url = "github:nix-community/emacs-overlay"; };
  };

  outputs = { self, flake-utils, darwin, home-manager, nixpkgs, emacs-overlay, ... }@inputs: {
    # M1 MBP, tested on macOS Ventura
    darwinConfigurations = {
      # Client MBP (MDM managed, hence the funky hostname)
      "MAC-NL6CFNNHRP" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin
        ];
        specialArgs = { inherit darwin home-manager nixpkgs; };
      };
    };

    # TODO: NixOS Configuration
  };
}
