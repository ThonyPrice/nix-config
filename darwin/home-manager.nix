{ config, pkgs, lib, ... }:

let
  common-programs = import ../common/home-manager.nix { config = config; pkgs = pkgs; lib = lib; };
  common-files = import ../common/files.nix { pkgs = pkgs; };
  home = builtins.getEnv "HOME";
  user = "thony"; in
{
  imports = [ <home-manager/nix-darwin> ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  # We use Homebrew to install impure software only (Mac Apps)
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
      upgrade = true;
    };
    brewPrefix = "/opt/homebrew/bin";
    taps = [
      "homebrew/cask-fonts"
      "homebrew/services"
       "koekeishiya/formulae"
    ];
    brews = [
      "koekeishiya/formulae/skhd"
      "koekeishiya/formulae/yabai"
    ];
    casks = pkgs.callPackage ./casks.nix {};
    # These app IDs are from using the mas CLI app
    # mas = mac app store, https://github.com/mas-cli/mas
    # homebrew.masApps = {
      # "1password" = 1333542190;
      # "drafts" = 1435957248;
    # };
  };

  # Enable home-manager to manage the XDG standard
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = {
      home.stateVersion = "22.11";
      home.enableNixpkgsReleaseCheck = false;
      home.packages = pkgs.callPackage ./packages.nix {};
      home.file = common-files // import ./files.nix { config = config; pkgs = pkgs; };
      programs = common-programs // {};
      home.sessionVariables = {
        PAGER = "less";
        CLICLOLOR = 1;
        EDITOR = "nvim";
      };

      # Skhd workaround
      # https://github.com/noctuid/dotfiles/blob/e6d93d17d3723dad06c8277b7565035df836d938/nix/darwin/default.nix#L292
      launchd.agents.skhd = {
        enable = true;
        config = {
          ProgramArguments = [
            "${pkgs.skhd}/bin/skhd"
            "-c"
            "${home}/.config/skhd/skhdrc"
          ];
          KeepAlive = true;
          RunAtLoad = true;
          ProcessType = "Interactive";
          EnvironmentVariables = {
            # NOTE: not necessary; will get PATH from non-interactive shell
            # config (.zshenv, which loads my profile)

            PATH = pkgs.lib.concatStringsSep ":" [
              #  "/run/current-system/sw/bin"
              #  "/nix/var/nix/profiles/default/"
              "${home}/.nix-profile/bin"
              #  "/bin"
              #  "/sbin"
              #  "/usr/bin"
              #  "/usr/sbin"
              #  "/usr/local/bin"
              #  "${homeDir}/.local/bin"
            ];
          };
          StandardOutPath = "/tmp/skhd.log";
          StandardErrorPath = "/tmp/skhd.log";
        };
      };
    };
  };
}
