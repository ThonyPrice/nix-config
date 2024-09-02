{ config, pkgs, lib, ... }: {

  users.users.${config.user}.shell = pkgs.zsh;
  programs.zsh.enable = true;

  home-manager.users.${config.user} = {

    # Packages used in abbreviations and aliases
    home.packages = with pkgs; [ eza ];

    programs.zsh = {
      enable = true;
      autocd = false;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        k = "kubectl";
        l = "eza --color=auto -la";
        v = "nvim";
        vim = "nvim";
        gauth = "gcloud auth login && gcloud auth application-default login";
      };
      initExtra = ''
        # nix
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
          . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi
        # end nix
        export PATH="${pkgs.emacs}/bin:$PATH"
        export PATH="${config.homePath}/.emacs.d/bin:$PATH"
        export PATH="${config.homePath}/git/nix-config/bin:$PATH"
        export PATH="${config.homePath}/.local/bin:$PATH"

        # Add relevant Homebrew directories to PATH
        if [ -x "$(command -v brew)" ]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
        fi

        # Add gcloud binary if installed
        if [ -d ${config.homePath}/google-cloud-sdk ]; then
          export PATH="${config.homePath}/google-cloud-sdk/bin:$PATH";
          source '${config.homePath}/google-cloud-sdk/completion.bash.inc';
        fi
      '';
    };

    programs.starship.enableZshIntegration = true;

  };
}
