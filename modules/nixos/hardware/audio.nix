{ config, pkgs, lib, ... }:


{

  config = lib.mkIf (pkgs.stdenv.isLinux && config.gui.enable) {

    sound.enable = true;

    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;

    # Enable PipeWire
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # If you want to use JACK applications, uncomment this
      # jack.enable = true;

      # Use the ecample session manager (no others are packaged yet so this is enabled by default
      # no need to refefine it in your config for now)
      # media-session.enable = true;
    };

    # Provides audio source with background noise filtered
    programs.noisetorch.enable = true;

    # These aren't necessary, but present a helpful GUI
    environment.systemPackages = with pkgs; [
      pamixer # Audio control
    ];

  };

}
