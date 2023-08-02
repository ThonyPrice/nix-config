{ pkgs }:

# These packages are shared across all machines
with pkgs; [
  bat # A cat(1) clone with syntax highlighting
  bottom
  btop
  clang
  cmake
  coreutils
  curl
  direnv
  emacs-all-the-icons-fonts
  exa
  fd
  gh
  git
  gnutls
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
  spicetify-cli
  tree-sitter
]
