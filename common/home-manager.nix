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

  starship =
    let
      # One of `latte`, `frappe`, `macchiato`, or `mocha`
      flavour = "macchiato";
    in
    {
      enable = true;
      enableZshIntegration = true;
      settings = {
        format = "$all"; # Remove this line to disable the default prompt format
        palette = "catppuccin_${flavour}";
      } // builtins.fromTOML (builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
            sha256 = "nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
          } + /palettes/${flavour}.toml));
    };
}
