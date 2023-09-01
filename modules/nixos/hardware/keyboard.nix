{ config, ... }: {

  config = {

    services.xserver = {

      # Configure keymap in X11
      layout = "se";
      xkbVariant = "mac";

      # Keyboard responsiveness
      autoRepeatDelay = 250;
      autoRepeatInterval = 40;

    };

    # Configure console keymap
    console.keyMap = "sv-latin1";

    # Use capslock as escape and/or control
    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = { main = { capslock = "overload(control, esc)"; }; };
        };
      };
    };

  };

}
