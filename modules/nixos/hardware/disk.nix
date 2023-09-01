{ config, pkgs, lib, ... }: {

  # Enable fstrim, which tracks free space on SSDs for garbage collection
  # More info: https://man7.org/linux/man-pages/man8/fstrim.8.html
  services.fstrim.enable = true;

}
