# Add my fork of emacs overlay pinning the
# emacs version to build from source

inputs: _final: prev:

let

  emacsOverlaySha256 =
    # Fork synced at 2023-08-09
    "01pj640a86cjhqyp58zzcz0w0963p9nvv4vv7l0pdr58cx0bsxrc";
  emacsUnstableFork =
    "https://github.com/thonyprice/emacs-overlay/archive/refs/heads/master.tar.gz";

in {

  emacs = null;
  # (import (builtins.fetchTarball {
  #   url = emacsUnstableFork;
  #   sha256 = emacsOverlaySha256;
  # }));
}
