{ config, pkgs, lib, ... }: {

  users.users.${config.user}.shell = pkgs.zsh;
  programs.zsh.enable =
    true;

  home-manager.users.${config.user} = {

    # Packages used in abbreviations and aliases
    home.packages = with pkgs; [ exa ];

    programs.zsh = {
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
        export PATH="${pkgs.emacs-unstable}/bin:$PATH"
        export PATH="${config.homePath}/.emacs.d/bin:$PATH"
        export PATH="${config.homePath}/git/nix-config/bin:$PATH"
      '';
    };

    programs.starship.enableZshIntegration = true;

  };
}
