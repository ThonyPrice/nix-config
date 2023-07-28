{ config, pkgs, lib, ... }:

let name = "Thony Price"; in
{
  # Shared shell configuration
  bat.enable = true;

  fzf.enable = true;
  fzf.enableZshIntegration = true;

  git = { enable = true; };

  zsh.enable = true;
  zsh.autocd = false;
  zsh.enableAutosuggestions = true;
  zsh.syntaxHighlighting.enable = true;
  zsh.shellAliases = {
    k = "kubectl";
    l = "ls --color=auto -F";
    ls = "ls --color=auto -F";
    v = "nvim";
    vim = "nvim";
  };
  zsh.initExtra = ''
    # nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # end nix
    export PATH=”$HOME/.emacs.d/bin:$PATH”
  '';
  starship.enable = true;
  starship.enableZshIntegration = true;
}
