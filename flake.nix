{
  description = "My system";

  # Other flakes that we want to pull from
  inputs = {

    # Used for system packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Used for MacOS system config
    darwin = {
      url = "github:/lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Used for user packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows =
        "nixpkgs"; # Use system packages list for their inputs
    };

    # Community packages; used for Firefox extensions
    nur.url = "github:nix-community/nur";

    # Use official Firefox binary for macOS
    firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Community Emacs overlay
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # Spice up Spotify client
    spicetify-nix.url = "github:the-argus/spicetify-nix";

    # Used to generate NixOS images for other platforms
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix language server
    nil = {
      url = "github:oxalica/nil/2023-04-03";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, ... }@inputs:

    let

      # Global configuration for my systems
      globals = let baseName = "thonyprice.com";
      in rec {
        user = "thony";
        fullName = "Thony Price";
        gitName = fullName;
        gitEmail = "thonyprice@gmail.com";
        dotfilesRepo = "https://github.com/thonyprice/nix-config";
      };

      # Common overlays to always use
      overlays = [
        inputs.nur.overlay
        (import ./overlays/emacs.nix inputs)
      ];

      # System types to support.
      supportedSystems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    in rec {

      # Contains my full system builds, including home-manager
      # nixos-rebuild switch --flake .#tempest
      nixosConfigurations = {
        # template = import ./hosts/template { inherit inputs globals overlays; };
      };

      # Contains my full Mac system builds, including home-manager
      # darwin-rebuild switch --flake .#lookingglass
      darwinConfigurations = {
        # MDM Managed, hence the funky hostname
        pluto =
          import ./hosts/pluto { inherit inputs globals overlays; };
      };

      # For quickly applying home-manager settings with:
      # home-manager switch --flake .#template
      homeConfigurations = {
        # template = nixosConfigurations.template.config.home-manager.users.${globals.user}.home;
        pluto =
          darwinConfigurations.pluto.config.home-manager.users."thony".home;
      };

      # Development environments
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system overlays; };
        in {

          # Used to run commands and edit files in this repo
          default = pkgs.mkShell {
            buildInputs = with pkgs; [ git stylua nixfmt shfmt shellcheck ];
          };

        });
    };
}
