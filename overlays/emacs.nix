# Add my fork of emacs overlay pinning the
# emacs version to build from source

inputs: _final: prev:

let

  pinnedSha256 =
    # Forked 2023-08-01
    "a0928a82ae68f4697f39c6e0ffcba763ea02a66b";
  emacsUnstableFork =
    "https://github.com/nix-community/emacs-overlay/archive/${pinnedSha256}.tar.gz";

in {
  emacs = (import (builtins.fetchTarball {
    url = emacsUnstableFork;
  }));
}
