{
    description = "My minimal MacOS Development Flake";
    inputs = {
        # Where we get most of out software.
        # It's a giant monorepo with recipes, derivations.
        # These define how to build software.
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        # Manages configs, links dotfiles into home directory
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # Control system level software and settings including fonts
        darwin.url = "github:lnl7/nix-darwin";
        darwin.inputs.nixpkgs.follows = "nixpkgs";
    };
    outputs = inputs: {
        # Special namespace in darwin derivation
        darwinConfiguration.thony = inputs.darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
            modules = [
                ({ pkgs, ...}: {
                    # Here go the Darwin prefs and config
                    programs.zsh.enable = true;
                    environment.shells = [ pkgs.bash pkgs.zsh ];
                    environment.loginShell = pkgs.zsh;
                    nix.extraOptions = ''
                        experimental-features = nix-command flakes
                    '';
                    systemPkgs = [ pkgs.coreutils ];
                    system.keyboard.enableKeyMapping = true;
                    system.keyboard.remapCapslocktoEscape = true;
                    # Danger! This define the following fornts as the only
                    # fonts installed on the system
                    fonts.fontDir.enable = false;
                    # fonts.fonts = [ ( pkgs.nerdfonts.override { fonts = ["Meslo"]; }) ];
                    service.nix-daemon.enable = true;
                    system.defaults.finder.AppleShowAllExtentions = true;
                    system.defaults.finder._FXShowPosixPathInTitle = true;
                    system.defaults.dock.autohide = true;
                    system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
                    system.defaults.NSGlobalDomain.KeyRepeat = 1;
                })
                (inputs.home-manager.darwinModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserlPkgs = true;
                        user.thony.imports = [
                            ({ pkgs, ... }: {
                                # Specify home manager config for user
                                home-packages = [ pkgs.ripgrep pkgs.fd pkgs.curl pkgs.less ];
                                home.sessionVariables = {
                                    PAGER = "less";
                                    CLICOLOR = 1;
                                    EDITOR = "nvim";
                                };
                                programs.bat.enable = true;
                                programs.bat.config.theme = "TwoDark";
                                programs.fzf.enable = true;
                                programs.fzf.enableZshIntegration = true;
                                programs.exa.enable = true;
                                programs.git.enable = true;
                                programs.zsh.enable = true;
                                programs.zsh.enableCompletion = true;
                                programs.zsh.enableAutosuggestions = true;
                                programs.zsh.enableSyntaxHighlighting = true;
                                programs.zsh.shellAliases = { ls = "ls --color=auto -F"; };
                                programs.starship.enable = true;
                                programs.starship.enableZshIntegration = true;
                            })
                        ];
                    };
                })
            ];
        };
    };
}
