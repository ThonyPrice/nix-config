{ config, pkgs, lib, ... }:

let name = "Thony Price"; in
{
  # Shared shell configuration
  bat.enable = true;

  exa.enable = true;

  fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  git.enable = true;

  zsh = {
    enable = true;
    autocd = false;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      k = "kubectl";
      l = "exa --color=auto -Fla";
      v = "nvim";
      vim = "nvim";
    };
    initExtra = ''
      # nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      # end nix
      export PATH=”$HOME/.emacs.d/bin:$PATH”
    '';
  };
  starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
