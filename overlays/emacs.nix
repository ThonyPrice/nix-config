# Add my fork of emacs overlay pinning the
# emacs version to build from source

inputs: _final: prev:

let

  pinnedSha256 =
    # Forked 2023-08-01
    "01q8bw40dh350zjx7g50ib4599sbsjgg711f794ib4d21ixh9xai";
  emacsUnstableFork =
    "https://github.com/thonyprice/emacs-overlay/archive/${pinnedSha256}.tar.gz";

in {
  emacs = (import (builtins.fetchTarball {
    url = emacsUnstableFork;
  }));
}
