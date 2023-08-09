{ config, ... }: {

  # FZF is a fuzzy-finder for the terminal

  home-manager.users.${config.user} = {

    programs.fzf.enable = true;

  };

}
