{ pkgs, ... }: {
  # here go the darwin preferences and config items
  programs.zsh.enable = true;
  environment.shells = [ pkgs.bash pkgs.zsh ];
  environment.loginShell = pkgs.zsh;
  environment.systemPackages = [ pkgs.coreutils ];
  # environment.systemPath = [ "/opt/homebrew/bin" ];
  # environment.pathsToLink = [ "/Applications" ];
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  fonts.fontDir.enable = false; # DANGER
  # fonts.fonts =
    # [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
  services.nix-daemon.enable = true;
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder._FXShowPosixPathInTitle = true;
  system.defaults.dock.autohide = true;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  # backwards compat; don't change
  system.stateVersion = 4;
  # homebrew = {
    # enable = true;
    # caskArgs.no_quarantine = true;
    # global.brewfile = true;
    # masApps = { };
    # casks = [ "raycast" "amethyst" ];
    # taps = [ "fujiapple852/trippy" ];
    # brews = [ "trippy" ];
  # };
}
