{ config, pkgs, lib, ... }:

let
  common-programs = import ../common/home-manager.nix { config = config; pkgs = pkgs; lib = lib; };
  common-files = import ../common/files.nix { pkgs = pkgs; };
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
  homebrew.enable = true;
  homebrew.onActivation = {
    autoUpdate = true;
    cleanup = "zap";
    upgrade = true;
  };
  homebrew.brewPrefix = "/opt/homebrew/bin";

  homebrew.taps = [
    "homebrew/services"
    "FelixKratz/formulae"
    "koekeishiya/formulae"
  ];

  homebrew.brews = [
    {
      name = "sketchybar";
      restart_service = true;
    }
    "koekeishiya/formulae/skhd"
    "koekeishiya/formulae/yabai"
  ];

  # These app IDs are from using the mas CLI app
  # mas = mac app store
  # https://github.com/mas-cli/mas
  #
  # $ mas search <app name>
  #
  homebrew.casks = pkgs.callPackage ./casks.nix {};
  # homebrew.masApps = {
    # "1password" = 1333542190;
    # "drafts" = 1435957248;
    # "hidden-bar" = 1452453066;
    # "wireguard" = 1451685025;
    # "yoink" = 457622435;
  # };

  # Set startup items
  # environment.launchAgents = {
  #   emacs = {
  #     source = config/gnu.emacs.daemon.plist;
  #     target = "Users/thony/Library/LaunchAgents/gnu.emacs.daemon.plist";
  #     copy = true;
  #   };
  # };

  # Enable home-manager to manage the XDG standard
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = {
      home.stateVersion = "22.11";
      home.enableNixpkgsReleaseCheck = false;
      home.packages = pkgs.callPackage ./packages.nix {};
      home.file = common-files // import ./files.nix { config = config; pkgs = pkgs; };
      programs = common-programs // {};
    };
  };
}
