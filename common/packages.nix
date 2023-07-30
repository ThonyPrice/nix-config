{ pkgs }:

# These packages are shared across all machines
with pkgs; [
  bat # A cat(1) clone with syntax highlighting
  bottom
  btop
  clang
  coreutils
  curl
  direnv
  emacs
  exa
  fd
  git
  go
  jq
  k9s
  kitty
  kubectl
  kubectx
  kubernetes-helm
  lazygit
  less
  neovim
  protobuf
  pyenv
  ripgrep
  tree-sitter
]
