{ config, ... }:

{

  config = {

    home-manager.users.${config.user}.services.dunst = {
      enable = false;
      settings = {
        global = {
          width = 300;
          height = 200;
          offset = "30x50";
          origin = "top-right";
          transparency = 0;
          padding = 20;
          horizontal_padding = 20;
          frame_color = "0xffB7BDF8";
        };

        urgency_normal = {
          background = "0xee24273A";
          foreground = "0xffA5ADCB";
          timeout = 10;
        };
      };
    };

  };

}
