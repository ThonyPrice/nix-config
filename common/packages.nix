{ pkgs }:

# These packages are shared across all machines
with pkgs; [
  bat # A cat(1) clone with syntax highlighting
  btop
  clang
  coreutils
  emacs
  fd
  git
  neovim
  ripgrep
]
